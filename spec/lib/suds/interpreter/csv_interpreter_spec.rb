require 'spec_helper'
require 'interpreter/csv_interpreter'

describe CSVInterpreter do
  subject {CSVInterpreter.new("path")}

  describe "#interpret_unit" do
    let(:headers) { %w{foo} }
    let(:row1) { {"foo" => "bar"} }
    let(:csvint) do
      csvint = CSVInterpreter.new("path")
      csvint.headers = headers
      csvint.interpret_unit row1
      csvint
    end

    context 'success' do
      subject { csvint.data }

      it {expect( subject.size ).to eq 1 }

      context "data" do
        subject { csvint.data.first }
        it {expect( subject.keys ).to include(*headers) }
        it {expect( subject.values ).to include(*row1.values) }
      end
    end

    context 'failure' do
      subject { csvint }
      let(:csvint) { CSVInterpreter.new("path") }

      it "raises an error if the headers aren't set" do
        expect{subject.interpret_unit %w{too many values}}.to raise_error(/Headers have not be set./)
      end

      it "raises an error if the header doesn't match the data" do
        subject.headers = ["row1"]
        expect{subject.interpret_unit %w{too many values}}.to raise_error(/Invalid data for current headers./)
      end
    end


  end
end
