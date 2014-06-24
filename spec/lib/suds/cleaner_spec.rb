require 'spec_helper'
require 'cleaner'

describe Cleaner do
  subject { Cleaner.new(){} }

  it { expect(Cleaner).to respond_to(:clean_array) }
  it { expect(Cleaner).to respond_to(:clean_hash) }

  describe "#clean" do
    let(:data) { [{row1: "TEST"}] }

    it "runs the provided block" do
      cleaner = Cleaner.new() do |_,v|
        v.downcase!
      end

      result = cleaner.clean data
      expect( result.first.to_a.flatten.last ).to match(/[^A-Z]/)
    end
  end

  context "failure" do
    it "raises an error when an non hash or array is passed in as the data" do
      expect {Cleaner.clean_array double("Fake")}.to raise_error(/Please provide either a hash or an array as the main parameter/)
    end
  end
end
