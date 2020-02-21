## Comparison:
* LightSerializer
* AMS
* Surrealist
* Blueprinter

All tests were made on MB Pro 2015 15" ruby 2.7.0.

```
Warming up --------------------------------------
      AMS : instance     3.360k i/100ms
Surrealist: instance through .surrealize
                         5.967k i/100ms
Light: instance through .to_json
                        11.219k i/100ms
Surrealist: instance through Surrealist::Serializer
                         4.141k i/100ms
ActiveModel::Serializers::JSON instance
                         3.972k i/100ms
         Blueprinter     7.770k i/100ms
Calculating -------------------------------------
      AMS : instance     34.399k (± 5.2%) i/s -    174.720k in   5.092856s
Surrealist: instance through .surrealize
                         63.060k (± 3.1%) i/s -    316.251k in   5.020067s
Light: instance through .to_json
                        117.218k (± 2.8%) i/s -    594.607k in   5.076736s
Surrealist: instance through Surrealist::Serializer
                         42.938k (± 2.4%) i/s -    215.332k in   5.017979s
ActiveModel::Serializers::JSON instance
                         41.108k (± 3.2%) i/s -    206.544k in   5.029439s
         Blueprinter     81.052k (± 5.1%) i/s -    411.810k in   5.093396s

Comparison:
Light: instance through .to_json:   117217.6 i/s
         Blueprinter:    81051.7 i/s - 1.45x  slower
Surrealist: instance through .surrealize:    63059.9 i/s - 1.86x  slower
Surrealist: instance through Surrealist::Serializer:    42938.3 i/s - 2.73x  slower
ActiveModel::Serializers::JSON instance:    41107.9 i/s - 2.85x  slower
      AMS : instance:    34399.0 i/s - 3.41x  slower

Warming up --------------------------------------
    AMS : collection     1.000  i/100ms
Surrealist: collection through Surrealist.surrealize_collection()
                         2.000  i/100ms
Light: collection through .to_json
                         4.000  i/100ms
Surrealist: collection through Surrealist::Serializer
                         2.000  i/100ms
ActiveModel::Serializers::JSON collection
                         1.000  i/100ms
Blueprinter collection
                         4.000  i/100ms
Calculating -------------------------------------
    AMS : collection     15.284  (± 6.5%) i/s -     77.000  in   5.053401s
Surrealist: collection through Surrealist.surrealize_collection()
                         23.420  (± 4.3%) i/s -    118.000  in   5.052662s
Light: collection through .to_json
                         47.073  (± 2.1%) i/s -    236.000  in   5.016778s
Surrealist: collection through Surrealist::Serializer
                         20.336  (± 9.8%) i/s -    102.000  in   5.047930s
ActiveModel::Serializers::JSON collection
                         18.517  (± 5.4%) i/s -     93.000  in   5.031023s
Blueprinter collection
                         39.442  (±12.7%) i/s -    192.000  in   5.091428s

Comparison:
Light: collection through .to_json:       47.1 i/s
Blueprinter collection:       39.4 i/s - 1.19x  slower
Surrealist: collection through Surrealist.surrealize_collection():       23.4 i/s - 2.01x  slower
Surrealist: collection through Surrealist::Serializer:       20.3 i/s - 2.31x  slower
ActiveModel::Serializers::JSON collection:       18.5 i/s - 2.54x  slower
    AMS : collection:       15.3 i/s - 3.08x  slower


------- Turning off AMS logger -------
Warming up --------------------------------------
AMS(without logging) : instance
                         3.389k i/100ms
Surrealist: instance through .surrealize
                         5.961k i/100ms
Light: instance through .to_json
                        11.179k i/100ms
Surrealist: instance through Surrealist::Serializer
                         4.160k i/100ms
ActiveModel::Serializers::JSON instance
                         4.013k i/100ms
         Blueprinter     8.052k i/100ms
Calculating -------------------------------------
AMS(without logging) : instance
                         34.713k (± 4.4%) i/s -    176.228k in   5.085983s
Surrealist: instance through .surrealize
                         62.371k (± 6.0%) i/s -    315.933k in   5.091054s
Light: instance through .to_json
                        117.991k (± 3.2%) i/s -    592.487k in   5.026749s
Surrealist: instance through Surrealist::Serializer
                         43.387k (± 2.4%) i/s -    220.480k in   5.084769s
ActiveModel::Serializers::JSON instance
                         41.593k (± 2.9%) i/s -    208.676k in   5.021385s
         Blueprinter     80.443k (± 8.1%) i/s -    402.600k in   5.039619s

Comparison:
Light: instance through .to_json:   117991.5 i/s
         Blueprinter:    80443.3 i/s - 1.47x  slower
Surrealist: instance through .surrealize:    62370.6 i/s - 1.89x  slower
Surrealist: instance through Surrealist::Serializer:    43387.3 i/s - 2.72x  slower
ActiveModel::Serializers::JSON instance:    41592.8 i/s - 2.84x  slower
AMS(without logging) : instance:    34713.2 i/s - 3.40x  slower

Warming up --------------------------------------
AMS(without logging) : collection
                         1.000  i/100ms
Surrealist: collection through Surrealist.surrealize_collection()
                         2.000  i/100ms
Light: collection through .to_json
                         4.000  i/100ms
Surrealist: collection through Surrealist::Serializer
                         2.000  i/100ms
ActiveModel::Serializers::JSON collection
                         1.000  i/100ms
Blueprinter collection
                         4.000  i/100ms
Calculating -------------------------------------
AMS(without logging) : collection
                         15.411  (± 6.5%) i/s -     77.000  in   5.008486s
Surrealist: collection through Surrealist.surrealize_collection()
                         23.688  (± 4.2%) i/s -    120.000  in   5.070850s
Light: collection through .to_json
                         47.411  (± 2.1%) i/s -    240.000  in   5.066069s
Surrealist: collection through Surrealist::Serializer
                         19.842  (±10.1%) i/s -    100.000  in   5.090176s
ActiveModel::Serializers::JSON collection
                         18.901  (± 5.3%) i/s -     95.000  in   5.033870s
Blueprinter collection
                         40.840  (± 4.9%) i/s -    204.000  in   5.003479s

Comparison:
Light: collection through .to_json:       47.4 i/s
Blueprinter collection:       40.8 i/s - 1.16x  slower
Surrealist: collection through Surrealist.surrealize_collection():       23.7 i/s - 2.00x  slower
Surrealist: collection through Surrealist::Serializer:       19.8 i/s - 2.39x  slower
ActiveModel::Serializers::JSON collection:       18.9 i/s - 2.51x  slower
AMS(without logging) : collection:       15.4 i/s - 3.08x  slower

Warming up --------------------------------------
AMS (associations): instance
                       777.000  i/100ms
Surrealist (associations): instance through .surrealize
                       992.000  i/100ms
Light (associations): instance through .to_json
                         2.938k i/100ms
Surrealist (associations): instance through Surrealist::Serializer
                         1.008k i/100ms
ActiveModel::Serializers::JSON (associations)
                         1.204k i/100ms
Blueprinter (associations)
                         2.113k i/100ms
Calculating -------------------------------------
AMS (associations): instance
                          7.721k (± 4.5%) i/s -     38.850k in   5.041613s
Surrealist (associations): instance through .surrealize
                          9.974k (± 2.5%) i/s -     50.592k in   5.075571s
Light (associations): instance through .to_json
                         30.021k (± 2.6%) i/s -    152.776k in   5.092383s
Surrealist (associations): instance through Surrealist::Serializer
                         10.165k (± 4.2%) i/s -     51.408k in   5.068469s
ActiveModel::Serializers::JSON (associations)
                         12.337k (± 3.1%) i/s -     62.608k in   5.079849s
Blueprinter (associations)
                         21.265k (± 3.6%) i/s -    107.763k in   5.074063s

Comparison:
Light (associations): instance through .to_json:    30021.1 i/s
Blueprinter (associations):    21265.1 i/s - 1.41x  slower
ActiveModel::Serializers::JSON (associations):    12336.7 i/s - 2.43x  slower
Surrealist (associations): instance through Surrealist::Serializer:    10165.2 i/s - 2.95x  slower
Surrealist (associations): instance through .surrealize:     9974.0 i/s - 3.01x  slower
AMS (associations): instance:     7720.7 i/s - 3.89x  slower

Warming up --------------------------------------
AMS (associations): collection
                         1.000  i/100ms
Surrealist (associations): collection through Surrealist.surrealize_collection()
                         1.000  i/100ms
Light (associations): collection through .to_json
                         2.000  i/100ms
Surrealist (associations): collection through Surrealist::Serializer
                         1.000  i/100ms
ActiveModel::Serializers::JSON (associations): collection
                         1.000  i/100ms
Blueprinter (associations): collection
                         1.000  i/100ms
Calculating -------------------------------------
AMS (associations): collection
                          5.628  (± 0.0%) i/s -     29.000  in   5.158533s
Surrealist (associations): collection through Surrealist.surrealize_collection()
                          6.754  (± 0.0%) i/s -     34.000  in   5.036950s
Light (associations): collection through .to_json
                         20.123  (± 5.0%) i/s -    102.000  in   5.072459s
Surrealist (associations): collection through Surrealist::Serializer
                          6.769  (± 0.0%) i/s -     34.000  in   5.026144s
ActiveModel::Serializers::JSON (associations): collection
                          9.035  (± 0.0%) i/s -     46.000  in   5.097702s
Blueprinter (associations): collection
                         15.646  (± 6.4%) i/s -     79.000  in   5.058134s

Comparison:
Light (associations): collection through .to_json:       20.1 i/s
Blueprinter (associations): collection:       15.6 i/s - 1.29x  slower
ActiveModel::Serializers::JSON (associations): collection:        9.0 i/s - 2.23x  slower
Surrealist (associations): collection through Surrealist::Serializer:        6.8 i/s - 2.97x  slower
Surrealist (associations): collection through Surrealist.surrealize_collection():        6.8 i/s - 2.98x  slower
AMS (associations): collection:        5.6 i/s - 3.58x  slower


------- Enabling Oj.optimize_rails() & Blueprinter config.generator = Oj -------
Warming up --------------------------------------
AMS(without logging) (with Oj): instance
                         3.961k i/100ms
Surrealist: instance through .surrealize
                         5.992k i/100ms
Light: instance through .to_json
                        11.180k i/100ms
Surrealist: instance through Surrealist::Serializer
                         4.169k i/100ms
ActiveModel::Serializers::JSON(with Oj) instance
                         5.032k i/100ms
Blueprinter(with Oj)     9.131k i/100ms
Calculating -------------------------------------
AMS(without logging) (with Oj): instance
                         63.382k (±21.9%) i/s -    285.192k in   5.019819s
Surrealist: instance through .surrealize
                         63.466k (± 2.2%) i/s -    317.576k in   5.006354s
Light: instance through .to_json
                        117.576k (± 2.8%) i/s -    592.540k in   5.043598s
Surrealist: instance through Surrealist::Serializer
                         42.932k (± 2.6%) i/s -    216.788k in   5.053261s
ActiveModel::Serializers::JSON(with Oj) instance
                         61.446k (±16.2%) i/s -    291.856k in   5.007754s
Blueprinter(with Oj)     95.658k (± 3.2%) i/s -    483.943k in   5.064356s

Comparison:
Light: instance through .to_json:   117576.3 i/s
Blueprinter(with Oj):    95657.7 i/s - 1.23x  slower
Surrealist: instance through .surrealize:    63466.0 i/s - 1.85x  slower
AMS(without logging) (with Oj): instance:    63382.5 i/s - 1.86x  slower
ActiveModel::Serializers::JSON(with Oj) instance:    61445.7 i/s - 1.91x  slower
Surrealist: instance through Surrealist::Serializer:    42931.6 i/s - 2.74x  slower

Warming up --------------------------------------
AMS(without logging) (with Oj): collection
                         2.000  i/100ms
Surrealist: collection through Surrealist.surrealize_collection()
                         2.000  i/100ms
Light: collection through .to_json
                         4.000  i/100ms
Surrealist: collection through Surrealist::Serializer
                         2.000  i/100ms
ActiveModel::Serializers::JSON(with Oj) collection
                         3.000  i/100ms
Blueprinter collection(with Oj)
                         4.000  i/100ms
Calculating -------------------------------------
AMS(without logging) (with Oj): collection
                         26.913  (± 7.4%) i/s -    136.000  in   5.070998s
Surrealist: collection through Surrealist.surrealize_collection()
                         23.421  (± 4.3%) i/s -    118.000  in   5.041755s
Light: collection through .to_json
                         46.893  (± 2.1%) i/s -    236.000  in   5.036927s
Surrealist: collection through Surrealist::Serializer
                         20.394  (± 4.9%) i/s -    102.000  in   5.014391s
ActiveModel::Serializers::JSON(with Oj) collection
                         33.469  (± 9.0%) i/s -    168.000  in   5.073981s
Blueprinter collection(with Oj)
                         39.616  (± 5.0%) i/s -    200.000  in   5.062459s

Comparison:
Light: collection through .to_json:       46.9 i/s
Blueprinter collection(with Oj):       39.6 i/s - 1.18x  slower
ActiveModel::Serializers::JSON(with Oj) collection:       33.5 i/s - 1.40x  slower
AMS(without logging) (with Oj): collection:       26.9 i/s - 1.74x  slower
Surrealist: collection through Surrealist.surrealize_collection():       23.4 i/s - 2.00x  slower
Surrealist: collection through Surrealist::Serializer:       20.4 i/s - 2.30x  slower

Warming up --------------------------------------
AMS (associations): instance
                         1.426k i/100ms
Surrealist (associations): instance through .surrealize
                         1.302k i/100ms
Light (associations): instance through .to_json
                         3.712k i/100ms
Surrealist (associations): instance through Surrealist::Serializer
                         1.336k i/100ms
ActiveModel::Serializers::JSON (associations)
                         2.527k i/100ms
Blueprinter (associations)
                         2.724k i/100ms
Calculating -------------------------------------
AMS (associations): instance
                         14.576k (± 5.2%) i/s -     74.152k in   5.100266s
Surrealist (associations): instance through .surrealize
                         13.194k (± 2.2%) i/s -     66.402k in   5.035181s
Light (associations): instance through .to_json
                         37.819k (± 2.8%) i/s -    189.312k in   5.009783s
Surrealist (associations): instance through Surrealist::Serializer
                         13.483k (± 2.5%) i/s -     68.136k in   5.057002s
ActiveModel::Serializers::JSON (associations)
                         25.725k (±14.4%) i/s -    126.350k in   5.046765s
Blueprinter (associations)
                         27.516k (± 3.1%) i/s -    138.924k in   5.053667s

Comparison:
Light (associations): instance through .to_json:    37819.2 i/s
Blueprinter (associations):    27516.2 i/s - 1.37x  slower
ActiveModel::Serializers::JSON (associations):    25725.3 i/s - 1.47x  slower
AMS (associations): instance:    14576.4 i/s - 2.59x  slower
Surrealist (associations): instance through Surrealist::Serializer:    13482.7 i/s - 2.81x  slower
Surrealist (associations): instance through .surrealize:    13193.9 i/s - 2.87x  slower

Warming up --------------------------------------
AMS (associations): collection
                         1.000  i/100ms
Surrealist (associations): collection through Surrealist.surrealize_collection()
                         1.000  i/100ms
Light (associations): collection through .to_json
                         2.000  i/100ms
Surrealist (associations): collection through Surrealist::Serializer
                         1.000  i/100ms
ActiveModel::Serializers::JSON (associations): collection
                         1.000  i/100ms
Blueprinter (associations): collection
                         1.000  i/100ms
Calculating -------------------------------------
AMS (associations): collection
                          8.448  (± 0.0%) i/s -     43.000  in   5.100105s
Surrealist (associations): collection through Surrealist.surrealize_collection()
                          6.861  (± 0.0%) i/s -     35.000  in   5.103246s
Light (associations): collection through .to_json
                         20.077  (± 0.0%) i/s -    102.000  in   5.083469s
Surrealist (associations): collection through Surrealist::Serializer
                          6.814  (± 0.0%) i/s -     35.000  in   5.140489s
ActiveModel::Serializers::JSON (associations): collection
                         16.713  (± 6.0%) i/s -     84.000  in   5.033276s
Blueprinter (associations): collection
                         16.138  (± 6.2%) i/s -     81.000  in   5.025043s

Comparison:
Light (associations): collection through .to_json:       20.1 i/s
ActiveModel::Serializers::JSON (associations): collection:       16.7 i/s - 1.20x  slower
Blueprinter (associations): collection:       16.1 i/s - 1.24x  slower
AMS (associations): collection:        8.4 i/s - 2.38x  slower
Surrealist (associations): collection through Surrealist.surrealize_collection():        6.9 i/s - 2.93x  slower
Surrealist (associations): collection through Surrealist::Serializer:        6.8 i/s - 2.95x  slower
```
