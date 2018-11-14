# light_serializer
Light and Fast serializer

[![Build Status](https://travis-ci.org/krim/light_serializer.svg?branch=master)](https://travis-ci.org/krim/light_serializer)

LS is a JSON Object Presenter that takes business objects and breaks them down into simple hashes and serializes them to JSON. It can be used in Rails in place of other serializers (like JBuilder or ActiveModelSerializers). It is designed to be simple, direct, and performant


## Usage
### Basic
If you have an object you would like serialized, simply create a serializer. Say, for example, you have a User record with the following attributes `[:uuid, :email, :first_name, :last_name, :address]`.

You may define a simple serializer like so:

```ruby
class UserSeriaizer < LightSerializer::Serializer
  attributes :uuid, :first_name, :last_name, :email
end
```

and then, in your code:
```ruby
puts UserSeriaizer.new(user).to_json # Output is a JSON string
```

And the output would look like:

```json
{
  "uuid": "733f0758-8f21-4719-875f-262c3ec743af",
  "first_name": "John",
  "last_name": "Doe",
  "email": "john.doe@some.fake.email.domain"
}
```

### Renaming

You can rename the resulting JSON keys in both fields and associations by define custom method:

```ruby
class UserSeriaizer < LightSerializer::Serializer
  attributes :id, :first_name, :last_name, :email

  def id
    object.uuid
  end
end
```

This will result in JSON that looks something like this:

```json
{
  "id": "92a5c732-2874-41e4-98fc-4123cd6cfa86",
  "first_name": "John",
  "last_name": "Doe",
  "email": "john.doe@some.fake.email.domain"
}
```

### Associations
You may include associated objects. Say for example, a user has projects:
```ruby
class ProjectSerializer < LightSerializer::Serializer
  attributes :uuid, :name
end

class UserSeriaizer < LightSerializer::Serializer
  attributes(
    :uuid,
    :first_name,
    :last_name,
    :email,
    { projects: ProjectSerializer }
  )
end
```

Usage:
```ruby
puts UserSeriaizer.new(user).to_json
```

Output:
```json
{
  "uuid": "733f0758-8f21-4719-875f-262c3ec743af",
  "first_name": "John",
  "last_name": "Doe",
  "email": "john.doe@some.fake.email.domain",
  "projects": [
    {
      "uuid": "dca94051-4195-42bc-a9aa-eb99f7723c82",
      "name": "Beach Cleanup"
    },
    {
      "uuid": "eb881bb5-9a51-4d27-8a29-b264c30e6160",
      "name": "Storefront Revamp"
    }
  ]
}
```

### Custom root
By default, returned JSON doesn't have root. You may specify it by option in serializer's initializer:
```ruby
puts UserSeriaizer.new(user, root: :person).to_json
```

Output:
```json
{
  "person": {
    "uuid": "733f0758-8f21-4719-875f-262c3ec743af",
    "first_name": "John",
    "last_name": "Doe",
    "email": "john.doe@some.fake.email.domain"
  }
}
```

### Collection serializer
Use `LightSerializer::SerializeCollection` to serialize collection of objects. You have to specify seriaizer, and can specify root and context.
```ruby
puts LightSerializer::SerializeCollection.new(users, serializer: UserSerializer, root: :users).to_json
```

Output:
```json
{
  "users": [
    {
      "uuid": "733f0758-8f21-4719-875f-262c3ec743af",
      "first_name": "John",
      "last_name": "Doe",
      "email": "john.doe@some.fake.email.domain"
    },
    {
      "uuid": "262c3ec743af-4719-4719-8f21-733f0758",
      "first_name": "Foo",
      "last_name": "Bar",
      "email": "foo.bar@some.fake.email.domain"
    },
    {
      ...
    }
  ]
}
```
