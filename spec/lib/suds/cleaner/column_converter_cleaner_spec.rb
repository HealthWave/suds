require 'spec_helper'
require 'suds/cleaner/column_converter_cleaner'

describe ColumnConverterCleaner do
  subject { ColumnConverterCleaner }
  let(:convert_hash) { {company: :name} }

  describe "#initialize" do
    it "takes a hash of strings mapped to strings" do
      subject.new convert_hash
    end
  end

  describe "#clean" do
    let(:data) { [{ company: "uri gorelik" }] }
    let(:cleaner) { cleaner = subject.new convert_hash, false }
    it "converts the keys of a hash" do
      results = cleaner.clean data
      expect(results.first.keys - convert_hash.values).to eq []
    end
  end
end
