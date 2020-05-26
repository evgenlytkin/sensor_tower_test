require 'csv'
require 'benchmark'

describe CSV do
  subject { CSV.parse(csv_string_data, separator, quote_symbol) }

  let(:separator) { "," }
  let(:quote_symbol) { "\"" }

  context 'when we have a new line symbol' do
    let(:csv_string_data) { "a,b,c\nd,e,f" }
    it { expect(subject).to eq([["a", "b", "c"], ["d", "e", "f"]])}
  end

  context 'when we have quoted and empty columns' do
    let(:csv_string_data) { "one,\"two wraps,\nonto \"\"two\"\" lines\",three\n4,,6" }
    it { expect(subject).to eq([["one", "two wraps,\nonto \"two\" lines", "three"], ["4", "", "6"]]) }
  end

  context 'when an each word is a new column' do
    let(:csv_string_data) { "each\tword\tis\ta\tnew\tcolumn" }
    let(:separator) { "\t" }
    let(:quote_symbol) { nil }
    it { expect(subject).to eq([["each", "word", "is", "a", "new", "column"]]) }
  end

  context 'when we won\'t create new columns because it was in quotes' do
    let(:csv_string_data) { "|the '\t' won't create new columns because it was|\tin\tquotes" }
    let(:separator) { "\t" }
    let(:quote_symbol) { "|" }
    it { expect(subject).to eq([["the '\t' won't create new columns because it was", "in", "quotes"]]) }
  end

  context 'when we have a custom delimiter and a quotes symbol' do
    let(:csv_string_data) { "|alternate|\t|\"quote\"|\n\n|character|\t|hint: |||" }
    let(:separator) { "\t" }
    let(:quote_symbol) { "|" }
    it { expect(subject).to eq([["alternate", "\"quote\""], [""], ["character", "hint: |"]]) }
  end

  context 'when there is an error' do
    let(:csv_string_data) { "\"dog\",\"cat\",\"uhoh" }
    it { expect{ subject }.to raise_error(ArgumentError, 'unclosed quote') }
  end

  context 'benchmark for one of cases' do
    let(:csv_string_data) { "each\tword\tis\ta\tnew\tcolumn" }
    it { puts Benchmark.measure { 100000.times { subject } } }
  end
end
