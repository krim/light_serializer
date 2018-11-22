## Comparison:
* LightSerializer
* AMS
* Surrealist
* Blueprinter

All tests were made on MB Pro 2015 15".

```
Warming up --------------------------------------
      AMS : instance     2.225k i/100ms
Surrealist: instance through .surrealize
                         4.012k i/100ms
LightSerializer: instance through .to_json
                         8.733k i/100ms
Surrealist: instance through Surrealist::Serializer
                         2.854k i/100ms
ActiveModel::Serializers::JSON instance
                         2.404k i/100ms
         Blueprinter     4.747k i/100ms
Calculating -------------------------------------
      AMS : instance     23.170k (± 3.1%) i/s -    117.925k in   5.094753s
Surrealist: instance through .surrealize
                         41.814k (± 2.6%) i/s -    212.636k in   5.089193s
LightSerializer: instance through .to_json
                         91.327k (± 2.5%) i/s -    462.849k in   5.071370s
Surrealist: instance through Surrealist::Serializer
                         29.131k (± 2.8%) i/s -    145.554k in   5.000956s
ActiveModel::Serializers::JSON instance
                         24.605k (± 2.0%) i/s -    125.008k in   5.082821s
         Blueprinter     49.770k (± 3.3%) i/s -    251.591k in   5.061158s

Comparison:
LightSerializer: instance through .to_json:    91327.3 i/s
         Blueprinter:    49770.4 i/s - 1.83x  slower
Surrealist: instance through .surrealize:    41813.5 i/s - 2.18x  slower
Surrealist: instance through Surrealist::Serializer:    29130.9 i/s - 3.14x  slower
ActiveModel::Serializers::JSON instance:    24604.5 i/s - 3.71x  slower
      AMS : instance:    23169.7 i/s - 3.94x  slower

Warming up --------------------------------------
    AMS : collection     1.000  i/100ms
Surrealist: collection through Surrealist.surrealize_collection()
                         1.000  i/100ms
LightSerializer: collection through .to_json
                         1.000  i/100ms
Surrealist: collection through Surrealist::Serializer
                         1.000  i/100ms
ActiveModel::Serializers::JSON collection
                         1.000  i/100ms
Blueprinter collection
                         1.000  i/100ms
Calculating -------------------------------------
    AMS : collection      5.801  (± 0.0%) i/s -     29.000  in   5.004853s
Surrealist: collection through Surrealist.surrealize_collection()
                          9.691  (± 0.0%) i/s -     49.000  in   5.063183s
LightSerializer: collection through .to_json
                         19.861  (± 5.0%) i/s -    100.000  in   5.044340s
Surrealist: collection through Surrealist::Serializer
                          7.964  (± 0.0%) i/s -     40.000  in   5.029143s
ActiveModel::Serializers::JSON collection
                          6.601  (± 0.0%) i/s -     33.000  in   5.002701s
Blueprinter collection
                         18.376  (± 5.4%) i/s -     92.000  in   5.015767s

Comparison:
LightSerializer: collection through .to_json:       19.9 i/s
Blueprinter collection:       18.4 i/s - same-ish: difference falls within error
Surrealist: collection through Surrealist.surrealize_collection():        9.7 i/s - 2.05x  slower
Surrealist: collection through Surrealist::Serializer:        8.0 i/s - 2.49x  slower
ActiveModel::Serializers::JSON collection:        6.6 i/s - 3.01x  slower
    AMS : collection:        5.8 i/s - 3.42x  slower


------- Turning off AMS logger -------
Warming up --------------------------------------
AMS(without logging) : instance
                         2.554k i/100ms
Surrealist: instance through .surrealize
                         4.451k i/100ms
LightSerializer: instance through .to_json
                         9.498k i/100ms
Surrealist: instance through Surrealist::Serializer
                         3.090k i/100ms
ActiveModel::Serializers::JSON instance
                         2.683k i/100ms
         Blueprinter     5.318k i/100ms
Calculating -------------------------------------
AMS(without logging) : instance
                         25.965k (± 3.8%) i/s -    130.254k in   5.024395s
Surrealist: instance through .surrealize
                         45.524k (± 4.9%) i/s -    231.452k in   5.097901s
LightSerializer: instance through .to_json
                         99.406k (± 2.8%) i/s -    503.394k in   5.067891s
Surrealist: instance through Surrealist::Serializer
                         32.110k (± 2.9%) i/s -    160.680k in   5.008350s
ActiveModel::Serializers::JSON instance
                         27.232k (± 2.8%) i/s -    136.833k in   5.028844s
         Blueprinter     54.973k (± 2.7%) i/s -    276.536k in   5.033870s

Comparison:
LightSerializer: instance through .to_json:    99406.0 i/s
         Blueprinter:    54973.4 i/s - 1.81x  slower
Surrealist: instance through .surrealize:    45523.7 i/s - 2.18x  slower
Surrealist: instance through Surrealist::Serializer:    32110.0 i/s - 3.10x  slower
ActiveModel::Serializers::JSON instance:    27232.1 i/s - 3.65x  slower
AMS(without logging) : instance:    25965.2 i/s - 3.83x  slower

Warming up --------------------------------------
AMS(without logging) : collection
                         1.000  i/100ms
Surrealist: collection through Surrealist.surrealize_collection()
                         1.000  i/100ms
LightSerializer: collection through .to_json
                         1.000  i/100ms
Surrealist: collection through Surrealist::Serializer
                         1.000  i/100ms
ActiveModel::Serializers::JSON collection
                         1.000  i/100ms
Blueprinter collection
                         1.000  i/100ms
Calculating -------------------------------------
AMS(without logging) : collection
                          5.729  (± 0.0%) i/s -     29.000  in   5.065254s
Surrealist: collection through Surrealist.surrealize_collection()
                          9.684  (± 0.0%) i/s -     49.000  in   5.063764s
LightSerializer: collection through .to_json
                         19.538  (± 5.1%) i/s -     98.000  in   5.026798s
Surrealist: collection through Surrealist::Serializer
                          7.836  (± 0.0%) i/s -     40.000  in   5.110566s
ActiveModel::Serializers::JSON collection
                          6.518  (± 0.0%) i/s -     33.000  in   5.067046s
Blueprinter collection
                         18.106  (± 5.5%) i/s -     91.000  in   5.034963s

Comparison:
LightSerializer: collection through .to_json:       19.5 i/s
Blueprinter collection:       18.1 i/s - same-ish: difference falls within error
Surrealist: collection through Surrealist.surrealize_collection():        9.7 i/s - 2.02x  slower
Surrealist: collection through Surrealist::Serializer:        7.8 i/s - 2.49x  slower
ActiveModel::Serializers::JSON collection:        6.5 i/s - 3.00x  slower
AMS(without logging) : collection:        5.7 i/s - 3.41x  slower

Warming up --------------------------------------
AMS (associations): instance
                       338.000  i/100ms
Surrealist (associations): instance through .surrealize
                       907.000  i/100ms
Light (associations): instance through .to_json
                         2.627k i/100ms
Surrealist (associations): instance through Surrealist::Serializer
                       921.000  i/100ms
ActiveModel::Serializers::JSON (associations)
                         1.024k i/100ms
Blueprinter (associations)
                         2.029k i/100ms
Calculating -------------------------------------
AMS (associations): instance
                          3.371k (± 2.9%) i/s -     16.900k in   5.018308s
Surrealist (associations): instance through .surrealize
                          9.139k (± 2.9%) i/s -     46.257k in   5.065403s
Light (associations): instance through .to_json
                         26.902k (± 2.8%) i/s -    136.604k in   5.081821s
Surrealist (associations): instance through Surrealist::Serializer
                          9.286k (± 3.0%) i/s -     46.971k in   5.062770s
ActiveModel::Serializers::JSON (associations)
                         10.313k (± 2.4%) i/s -     52.224k in   5.066930s
Blueprinter (associations)
                         20.826k (± 3.4%) i/s -    105.508k in   5.071876s

Comparison:
Light (associations): instance through .to_json:    26902.2 i/s
Blueprinter (associations):    20825.6 i/s - 1.29x  slower
ActiveModel::Serializers::JSON (associations):    10312.9 i/s - 2.61x  slower
Surrealist (associations): instance through Surrealist::Serializer:     9286.0 i/s - 2.90x  slower
Surrealist (associations): instance through .surrealize:     9139.5 i/s - 2.94x  slower
AMS (associations): instance:     3370.6 i/s - 7.98x  slower

Warming up --------------------------------------
AMS (associations): collection
                         1.000  i/100ms
Surrealist (associations): collection through Surrealist.surrealize_collection()
                         1.000  i/100ms
Light (associations): collection through .to_json
                         1.000  i/100ms
Surrealist (associations): collection through Surrealist::Serializer
                         1.000  i/100ms
ActiveModel::Serializers::JSON (associations): collection
                         1.000  i/100ms
Blueprinter (associations): collection
                         1.000  i/100ms
Calculating -------------------------------------
AMS (associations): collection
                          1.172  (± 0.0%) i/s -      6.000  in   5.138824s
Surrealist (associations): collection through Surrealist.surrealize_collection()
                          2.694  (± 0.0%) i/s -     14.000  in   5.203211s
Light (associations): collection through .to_json
                          8.001  (± 0.0%) i/s -     40.000  in   5.008966s
Surrealist (associations): collection through Surrealist::Serializer
                          2.635  (± 0.0%) i/s -     14.000  in   5.319793s
ActiveModel::Serializers::JSON (associations): collection
                          3.309  (± 0.0%) i/s -     17.000  in   5.144606s
Blueprinter (associations): collection
                          7.817  (± 0.0%) i/s -     40.000  in   5.128954s

Comparison:
Light (associations): collection through .to_json:        8.0 i/s
Blueprinter (associations): collection:        7.8 i/s - 1.02x  slower
ActiveModel::Serializers::JSON (associations): collection:        3.3 i/s - 2.42x  slower
Surrealist (associations): collection through Surrealist.surrealize_collection():        2.7 i/s - 2.97x  slower
Surrealist (associations): collection through Surrealist::Serializer:        2.6 i/s - 3.04x  slower
AMS (associations): collection:        1.2 i/s - 6.83x  slower


------- Enabling Oj.optimize_rails() & Blueprinter config.generator = Oj -------
Warming up --------------------------------------
AMS(without logging) (with Oj): instance
                         4.286k i/100ms
Surrealist: instance through .surrealize
                         4.466k i/100ms
LightSerializer: instance through .to_json
                         9.569k i/100ms
Surrealist: instance through Surrealist::Serializer
                         3.124k i/100ms
ActiveModel::Serializers::JSON(with Oj) instance
                         4.035k i/100ms
Blueprinter(with Oj)     6.773k i/100ms
Calculating -------------------------------------
AMS(without logging) (with Oj): instance
                         49.629k (± 4.8%) i/s -    248.588k in   5.020623s
Surrealist: instance through .surrealize
                         45.766k (± 3.2%) i/s -    232.232k in   5.079519s
LightSerializer: instance through .to_json
                         99.043k (± 2.6%) i/s -    497.588k in   5.027351s
Surrealist: instance through Surrealist::Serializer
                         31.665k (± 3.4%) i/s -    159.324k in   5.037471s
ActiveModel::Serializers::JSON(with Oj) instance
                         45.115k (± 4.0%) i/s -    225.960k in   5.017009s
Blueprinter(with Oj)     70.319k (± 2.5%) i/s -    352.196k in   5.011834s

Comparison:
LightSerializer: instance through .to_json:    99042.9 i/s
Blueprinter(with Oj):    70319.0 i/s - 1.41x  slower
AMS(without logging) (with Oj): instance:    49629.4 i/s - 2.00x  slower
Surrealist: instance through .surrealize:    45766.5 i/s - 2.16x  slower
ActiveModel::Serializers::JSON(with Oj) instance:    45114.9 i/s - 2.20x  slower
Surrealist: instance through Surrealist::Serializer:    31665.1 i/s - 3.13x  slower

Warming up --------------------------------------
AMS(without logging) (with Oj): collection
                         1.000  i/100ms
Surrealist: collection through Surrealist.surrealize_collection()
                         1.000  i/100ms
LightSerializer: collection through .to_json
                         1.000  i/100ms
Surrealist: collection through Surrealist::Serializer
                         1.000  i/100ms
ActiveModel::Serializers::JSON(with Oj) collection
                         1.000  i/100ms
Blueprinter collection(with Oj)
                         2.000  i/100ms
Calculating -------------------------------------
AMS(without logging) (with Oj): collection
                          9.921  (± 0.0%) i/s -     50.000  in   5.047071s
Surrealist: collection through Surrealist.surrealize_collection()
                          9.459  (± 0.0%) i/s -     48.000  in   5.080945s
LightSerializer: collection through .to_json
                         19.470  (± 5.1%) i/s -     98.000  in   5.046335s
Surrealist: collection through Surrealist::Serializer
                          7.720  (± 0.0%) i/s -     39.000  in   5.063697s
ActiveModel::Serializers::JSON(with Oj) collection
                         10.796  (± 9.3%) i/s -     54.000  in   5.024268s
Blueprinter collection(with Oj)
                         20.156  (± 5.0%) i/s -    102.000  in   5.064738s

Comparison:
Blueprinter collection(with Oj):       20.2 i/s
LightSerializer: collection through .to_json:       19.5 i/s - same-ish: difference falls within error
ActiveModel::Serializers::JSON(with Oj) collection:       10.8 i/s - 1.87x  slower
AMS(without logging) (with Oj): collection:        9.9 i/s - 2.03x  slower
Surrealist: collection through Surrealist.surrealize_collection():        9.5 i/s - 2.13x  slower
Surrealist: collection through Surrealist::Serializer:        7.7 i/s - 2.61x  slower

Warming up --------------------------------------
AMS (associations): instance
                       381.000  i/100ms
Surrealist (associations): instance through .surrealize
                       677.000  i/100ms
Light (associations): instance through .to_json
                         2.074k i/100ms
Surrealist (associations): instance through Surrealist::Serializer
                       687.000  i/100ms
ActiveModel::Serializers::JSON (associations)
                         1.390k i/100ms
Blueprinter (associations)
                         1.851k i/100ms
Calculating -------------------------------------
AMS (associations): instance
                          3.743k (± 5.9%) i/s -     19.050k in   5.108122s
Surrealist (associations): instance through .surrealize
                          6.817k (± 2.8%) i/s -     34.527k in   5.068641s
Light (associations): instance through .to_json
                         21.131k (± 3.0%) i/s -    105.774k in   5.010100s
Surrealist (associations): instance through Surrealist::Serializer
                          6.874k (± 3.1%) i/s -     34.350k in   5.001779s
ActiveModel::Serializers::JSON (associations)
                         13.996k (± 3.2%) i/s -     70.890k in   5.069785s
Blueprinter (associations)
                         19.964k (± 3.5%) i/s -     99.954k in   5.013021s

Comparison:
Light (associations): instance through .to_json:    21131.3 i/s
Blueprinter (associations):    19964.2 i/s - same-ish: difference falls within error
ActiveModel::Serializers::JSON (associations):    13996.4 i/s - 1.51x  slower
Surrealist (associations): instance through Surrealist::Serializer:     6874.1 i/s - 3.07x  slower
Surrealist (associations): instance through .surrealize:     6817.0 i/s - 3.10x  slower
AMS (associations): instance:     3742.8 i/s - 5.65x  slower

Warming up --------------------------------------
AMS (associations): collection
                         1.000  i/100ms
Surrealist (associations): collection through Surrealist.surrealize_collection()
                         1.000  i/100ms
Light (associations): collection through .to_json
                         1.000  i/100ms
Surrealist (associations): collection through Surrealist::Serializer
                         1.000  i/100ms
ActiveModel::Serializers::JSON (associations): collection
                         1.000  i/100ms
Blueprinter (associations): collection
                         1.000  i/100ms
Calculating -------------------------------------
AMS (associations): collection
                          1.387  (± 0.0%) i/s -      7.000  in   5.077429s
Surrealist (associations): collection through Surrealist.surrealize_collection()
                          2.649  (± 0.0%) i/s -     14.000  in   5.291537s
Light (associations): collection through .to_json
                          7.857  (± 0.0%) i/s -     40.000  in   5.103876s
Surrealist (associations): collection through Surrealist::Serializer
                          2.602  (± 0.0%) i/s -     13.000  in   5.003615s
ActiveModel::Serializers::JSON (associations): collection
                          5.693  (± 0.0%) i/s -     29.000  in   5.104138s
Blueprinter (associations): collection
                          8.603  (± 0.0%) i/s -     43.000  in   5.011885s

Comparison:
Blueprinter (associations): collection:        8.6 i/s
Light (associations): collection through .to_json:        7.9 i/s - 1.09x  slower
ActiveModel::Serializers::JSON (associations): collection:        5.7 i/s - 1.51x  slower
Surrealist (associations): collection through Surrealist.surrealize_collection():        2.6 i/s - 3.25x  slower
Surrealist (associations): collection through Surrealist::Serializer:        2.6 i/s - 3.31x  slower
AMS (associations): collection:        1.4 i/s - 6.20x  slower
```
