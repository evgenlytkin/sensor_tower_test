# Sensor Tower CSV Parser

I've chosen a basic implementation where I am iterating through each character, storing state in a couple of variables, and handling final state and potential unclosed quote when iteration is over. Another implementation I've consider at first was to iterate line by line and using Regex to split data, but it seemed more complex while yielding potentially not as good performance. I didn't have the time to write and benchmark this other implementation though, so that's just suppositions.

## To run

    git clone git@github.com:hartator/sensor-tower-csv-parser.git
    cd sensor-tower-csv-parser
    bundle
    rspec
    
## Files

* [Specs](https://github.com/hartator/sensor-tower-csv-parser/blob/master/spec/csv_spec.rb)
* [Actual implementation](https://github.com/hartator/sensor-tower-csv-parser/blob/master/lib/csv.rb)

## Expected output

    ➜  sensor-tower-csv-parser git:(master) ruby --version
    ruby 2.4.2p198 (2017-09-14 revision 59899) [x86_64-darwin16]
    ➜  sensor-tower-csv-parser git:(master) rspec --version
    RSpec 3.8
      - rspec-core 3.8.0
      - rspec-expectations 3.8.1
      - rspec-mocks 3.8.0
      - rspec-support 3.8.0
    ➜  sensor-tower-csv-parser git:(master) rspec
    ....

    Benchmark results:   0.100000   0.000000   0.100000 (  0.102629)


    Finished in 0.10627 seconds (files took 0.11822 seconds to load)
    4 examples, 0 failures
