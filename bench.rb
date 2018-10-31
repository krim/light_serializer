# rubocop:disable Metrics/AbcSize,Metrics/MethodLength
require 'surrealist'
require_relative 'lib/light_serializer'
require 'benchmark/ips'
require 'active_record'
require 'active_model'
require 'active_model_serializers'
require 'blueprinter'
require 'pry'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: ':memory:',
)

ActiveRecord::Migration.verbose = false
ActiveRecord::Schema.define do
  create_table :users do |table|
    table.column :name, :string
    table.column :email, :string
  end

  create_table :authors do |table|
    table.column :name, :string
    table.column :last_name, :string
    table.column :age, :int
  end

  create_table :books do |table|
    table.column :title, :string
    table.column :year, :string
    table.belongs_to :author, foreign_key: true
  end
end

ActiveModelSerializers.config.adapter = :json

def random_name
  ('a'..'z').to_a.shuffle.join('').first(10).capitalize
end

class User < ActiveRecord::Base
  include Surrealist

  json_schema { { name: String, email: String } }
end

class UserLightSerializer
  include LightSerializer::Serialization

  attributes(:name, :email)
end

class UserSerializer < ActiveModel::Serializer
  attributes :name, :email
end

class UserSurrealistSerializer < Surrealist::Serializer
  json_schema { { name: String, email: String } }
end

class UserAMSSerializer < ActiveModel::Serializer
  attributes :name, :email
end

class UserBlueprint < Blueprinter::Base
  fields :name, :email
end

### Associations ###

class BookLightSerializer
  include LightSerializer::Serialization

  attributes(:title, :year)
end

class AuthorLightSerializer
  include LightSerializer::Serialization

  attributes(
    :name,
    :last_name,
    :full_name,
    :age,
    books: BookLightSerializer
  )
end

class AuthorSurrealistSerializer < Surrealist::Serializer
  json_schema do
    { name: String, last_name: String, full_name: String, age: Integer, books: Array }
  end

  def books
    object.books.to_a
  end

  def full_name
    "#{object.name} #{object.last_name}"
  end
end

class BookSurrealistSerializer < Surrealist::Serializer
  json_schema { { title: String, year: String } }
end

class BookAMSSerializer < ActiveModel::Serializer
  attributes :title, :year
end

class BookBlueprint < Blueprinter::Base
  fields :title, :year
end

class AuthorAMSSerializer < ActiveModel::Serializer
  attributes :name, :last_name, :full_name, :age
  has_many :books, serializer: BookAMSSerializer
end

class AuthorBlueprint < Blueprinter::Base
  fields :name, :last_name, :age
  field :full_name do |author|
    "#{author.name} #{author.last_name}"
  end
  association :books, blueprint: BookBlueprint
end

class Author < ActiveRecord::Base
  include Surrealist
  surrealize_with AuthorSurrealistSerializer

  has_many :books

  def full_name
    "#{name} #{last_name}"
  end
end

class Book < ActiveRecord::Base
  include Surrealist
  surrealize_with BookSurrealistSerializer

  belongs_to :author, required: true
end

N = 3000
N.times { User.create!(name: random_name, email: "#{random_name}@test.com") }
(N / 2).times { Author.create!(name: random_name, last_name: random_name, age: rand(80)) }
N.times { Book.create!(title: random_name, year: "19#{rand(10..99)}", author_id: rand(1..N / 2)) }

def sort(obj)
  case obj
  when Array then obj.map { |el| sort(el) }
  when Hash then obj.transform_values { |v| sort(v) }
  else obj
  end
end

def check_correctness(serializers)
  results = serializers.map(&:call).map { |r| sort(JSON.parse(r)) }
  raise 'Results are not the same' if results.uniq.size > 1
end

def benchmark(names, serializers)
  check_correctness(serializers)

  Benchmark.ips do |x|
    x.config(time: 5, warmup: 2)

    names.zip(serializers).each { |name, proc| x.report(name, &proc) }

    x.compare!
  end
end

def benchmark_instance(ams_arg: '', oj_arg: '')
  user = User.find(rand(1..N))

  names = ["AMS#{[ams_arg, oj_arg].join(' ')}: instance",
           'Surrealist: instance through .surrealize',
           'Light: instance through .to_json',
           'Surrealist: instance through Surrealist::Serializer',
           "ActiveModel::Serializers::JSON#{oj_arg} instance",
           "Blueprinter#{oj_arg}"]

  serializers = [-> { UserAMSSerializer.new(user).to_json },
                 -> { user.surrealize },
                 -> { UserLightSerializer.new(user).to_json },
                 -> { UserSurrealistSerializer.new(user).surrealize },
                 -> { user.to_json(only: %i[name email]) },
                 -> { UserBlueprint.render(user) }]

  benchmark(names, serializers)
end

def benchmark_collection(ams_arg: '', oj_arg: '')
  users = User.all

  names = ["AMS#{[ams_arg, oj_arg].join(' ')}: collection",
           'Surrealist: collection through Surrealist.surrealize_collection()',
           'Light: collection through .to_json',
           'Surrealist: collection through Surrealist::Serializer',
           "ActiveModel::Serializers::JSON#{oj_arg} collection",
           "Blueprinter collection#{oj_arg}"]

  serializers = [lambda do
                   ActiveModel::Serializer::CollectionSerializer.new(
                     users, root: nil, serializer: UserAMSSerializer
                   ).to_json
                 end,
                 -> { Surrealist.surrealize_collection(users) },
                 -> { UserLightSerializer.new(users).to_json },
                 -> { UserSurrealistSerializer.new(users).surrealize },
                 -> { users.to_json(only: %i[name email]) },
                 -> { UserBlueprint.render(users) }]

  benchmark(names, serializers)
end

def benchmark_associations_instance
  instance = Author.find(rand((1..(N / 2))))

  names = ['AMS (associations): instance',
           'Surrealist (associations): instance through .surrealize',
           'Light (associations): instance through .to_json',
           'Surrealist (associations): instance through Surrealist::Serializer',
           'ActiveModel::Serializers::JSON (associations)',
           'Blueprinter (associations)']

  serializers = [-> { AuthorAMSSerializer.new(instance).to_json },
                 -> { instance.surrealize },
                 -> { AuthorLightSerializer.new(instance).to_json },
                 -> { AuthorSurrealistSerializer.new(instance).surrealize },
                 lambda do
                   instance.to_json(only: %i[name last_name age], methods: %i[full_name],
                                    include: { books: { only: %i[title year] } })
                 end,
                 -> { AuthorBlueprint.render(instance) }]

  benchmark(names, serializers)
end

def benchmark_associations_collection
  collection = Author.all

  names = ['AMS (associations): collection',
           'Surrealist (associations): collection through Surrealist.surrealize_collection()',
           'Light (associations): collection through .to_json',
           'Surrealist (associations): collection through Surrealist::Serializer',
           'ActiveModel::Serializers::JSON (associations): collection',
           'Blueprinter (associations): collection']

  serializers = [lambda do
                   ActiveModel::Serializer::CollectionSerializer.new(
                     collection, root: nil, serializer: AuthorAMSSerializer
                   ).to_json
                 end,
                 -> { Surrealist.surrealize_collection(collection) },
                 -> { AuthorLightSerializer.new(collection).to_json },
                 -> { AuthorSurrealistSerializer.new(collection).surrealize },
                 lambda do
                   collection.to_json(only: %i[name last_name age], methods: %i[full_name],
                                      include: { books: { only: %i[title year] } })
                 end,
                 -> { AuthorBlueprint.render(collection) }]

  benchmark(names, serializers)
end

# Default configuration
benchmark_instance
benchmark_collection

# With AMS logger turned off
puts "\n------- Turning off AMS logger -------\n"
ActiveModelSerializers.logger.level = Logger::Severity::UNKNOWN

benchmark_instance(ams_arg: '(without logging)')
benchmark_collection(ams_arg: '(without logging)')

# Associations
benchmark_associations_instance
benchmark_associations_collection

puts "\n------- Enabling Oj.optimize_rails() & Blueprinter config.generator = Oj -------\n"
Oj.optimize_rails
Blueprinter.configure do |config|
  config.generator = Oj
end

benchmark_instance(ams_arg: '(without logging)', oj_arg: '(with Oj)')
benchmark_collection(ams_arg: '(without logging)', oj_arg: '(with Oj)')

# Associations
benchmark_associations_instance
benchmark_associations_collection
