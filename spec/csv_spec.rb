require 'csv'
require 'benchmark'

describe CSV do

  it "returns valid array with basic CSV" do
    basic_csv = "a,b,c\nd,e,f"
    expect(CSV.parse(basic_csv)).to eq(
      [["a", "b", "c"], ["d", "e", "f"]]
    )
  end

  it "returns valid array with quoted CSV" do
    quoted_csv = "one,\"two wraps,\nonto \"\"two\"\" lines\",three\n4,,6"
    expect(CSV.parse(quoted_csv)).to eq(
      [["one", "two wraps,\nonto \"two\" lines", "three"], ["4", "", "6"]]
    )
  end

  it "returns valid array with complex CSV" do
    complex_csv = "|alternate|\t|\"quote\"|\n\n|character|\t|hint: |||"
    expect(CSV.parse(complex_csv, "\t", "|")).to eq(
      [["alternate", "\"quote\""], [""], ["character", "hint: |"]]
    )
  end

  it "returns argument error with unclosed quote CSV" do
    csv_with_error = "\"dog\",\"cat\",\"uhoh"
    expect{CSV.parse(csv_with_error)}.to raise_error(ArgumentError, "unclosed quote")
  end

  # Not best pratice to put benchmark code into Specs but for the sake 
  # of keeping things in 1 file for the code challenge
  after(:all) do
    complex_csv = "|alternate|\t|\"quote\"|\n\n|character|\t|hint: |||"
    results = Benchmark.measure do
     10_000.times { CSV.parse(complex_csv, "\t", "|") }
    end
    puts "\n\nBenchmark results: #{results}"
  end

end