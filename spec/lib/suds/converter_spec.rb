require 'spec_helper'
require 'converter'

describe Converter do
  subject { Converter }
  
  describe "#convert!" do
    it "it raises an error if no output file was specified" do
      expect { Converter.new.convert!(double) }.to raise_error(/Cannot output to file if outfile is not set./)
    end
  end
end
