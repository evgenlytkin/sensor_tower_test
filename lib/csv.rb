require 'benchmark'

class CSV
  def self.parse(csv_string_data, separator = ",", quotes_symbol = "\"")
    start_quote = false
    result = [[]]
    column_value = ''

    csv_string_data.each_char do |symbol|
      if symbol == quotes_symbol
        if start_quote
          column_value += symbol
        end

        start_quote ^= true
        next
      end


      if !start_quote && (symbol == separator || symbol == "\n")
        if column_value[-1] == quotes_symbol
          column_value = column_value[0..-2]
        end

        result.last << column_value
        column_value = ''

        if symbol == "\n"
          result << []
        end

        next
      end

      column_value += symbol
    end

    if start_quote
      raise ArgumentError.new('unclosed quote')
    else
      if column_value[-1] == quotes_symbol
        column_value = column_value[0..-2]
      end

      result.last << column_value
    end

    result
  end
end

describe CSV do
  subject { CSV.parse(csv_string_data, separator, quotes_symbol) }

  let(:separator) { "," }
  let(:quotes_symbol) { "\"" }

  context 'when we have a new line symbol' do
    let(:csv_string_data) { "a,b,c\nd,e,f" }
    it { expect(subject).to eq([["a", "b", "c"], ["d", "e", "f"]])}
  end

  context 'when we have quoted and empty columns' do
    let(:csv_string_data) { "one,\"two wraps,\nonto \"\"two\"\" lines\",three\n4,,6" }
    it { expect(subject).to eq([["one", "two wraps,\nonto \"two\" lines", "three"], ["4", "", "6"]]) }
  end

  context 'when we have a custom delimiter and a quotes symbol' do
    let(:csv_string_data) { "|alternate|\t|\"quote\"|\n\n|character|\t|hint: |||" }
    let(:separator) { "\t" }
    let(:quotes_symbol) { "|" }
    it { expect(subject).to eq([["alternate", "\"quote\""], [""], ["character", "hint: |"]]) }
  end

  context 'when there is an error' do
    let(:csv_string_data) { "\"dog\",\"cat\",\"uhoh" }
    it { expect{ subject }.to raise_error(ArgumentError, 'unclosed quote') }
  end

  context 'benchmark' do
    let(:csv_string_data) { "one,\"two wraps,\nonto \"\"two\"\" lines\",three\n4,,6" }
    it { puts Benchmark.measure { 100000.times { subject } } }
  end
end
