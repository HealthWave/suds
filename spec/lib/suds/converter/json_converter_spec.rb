require 'spec_helper'
require 'converter/json_converter'

describe JSONConverter do
  subject { JSONConverter }
  let(:unconverted_data) { [{row1: 1, row2:2}] * 5 }
  it "converts an array to json" do
    converter = subject.new(unconverted_data)
    expect( converter.convert(unconverted_data).class ).to be String
    expect( JSON.parse(converter.converted_data, symbolize_names: true) ).to eq unconverted_data
  end
end
