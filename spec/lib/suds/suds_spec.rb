require 'spec_helper'
require 'suds'
require 'cleaner'
require 'converter'
require 'interpreter'

describe Suds do
  subject { Suds }

  describe '#initialize' do
    subject { Suds.new double("Interpreter") }
    it { should respond_to(:data) }
  end

  context 'plugins' do
    let(:list) { subject.new double("Interpreter") }

    describe '#add_cleaner' do
      it "adds a cleaner" do
        cleaner = Cleaner.new(){}
        list.add_cleaner cleaner
        expect(list.cleaners ).to_not be_empty
      end

      it 'raises an error if the added cleaner is not a Cleaner' do
        cleaner = double
        expect { list.add_cleaner cleaner }.to raise_error(Regexp.new("#{cleaner.class} is not a valid Cleaner."))
      end
    end

    describe '#add_converter' do
      it 'adds a converter' do
        list.add_converter Converter.new([])
        expect( list.converters ).to_not be_empty
      end
      it 'raises an error if the added converter is not a Converter' do
        converter = double
        expect { list.add_converter converter }.to raise_error(Regexp.new("#{converter.class} is not a valid Converter."))
      end
    end

  end

  context 'data manipulation' do
    let(:data) { {row1: :a, row2: :b} }

    let(:special_converter) do
      converter = double("SpecialConverter")
      allow(converter).to receive(:is_a?).with(Converter).and_return(true)
      allow(converter).to receive(:convert)
      allow(converter).to receive(:convert!)
      allow(converter).to receive(:data).and_return([{a: '1'}])
      converter
    end

    let(:special_cleaner) do
      cleaner = double("SpecialCleaner")
      allow(cleaner).to receive(:is_a?).with(Cleaner).and_return(true)
      allow(cleaner).to receive(:clean).and_return({z: "9"})
      cleaner
    end

    let(:special_interpreter) do
      interpreter = double("SpecialInterpreter")
      allow(interpreter).to receive(:is_a?).with(Interpreter).and_return(true)
      allow(interpreter).to receive(:interpret)
      allow(interpreter).to receive(:data).and_return(data)
      interpreter
    end

    describe '#clean' do
      it 'cleans the data' do
        expect( special_cleaner ).to receive(:clean)

        list = Suds.new(special_interpreter)
        list.add_cleaner(special_cleaner)
        list.clean

        expect( list.interpreter.data ).to_not eq( list.data )
      end

    end

    describe '#convert' do
      let(:list) { Suds.new(special_interpreter) }
      before do
        list.add_converter special_converter
      end

      it 'converts the data into a portable type' do
        expect( special_converter ).to receive(:convert)
        list.convert
      end

      it 'can convert without cleaning first' do
        allow( special_interpreter ).to receive(:interpret).and_return([])
        list.convert
        expect( list.data ).to_not be_nil
      end

      it 'returns a list of strings' do
        allow( special_converter ).to receive(:convert).and_return("converted data")
        convert = list.convert
        expect( convert ).to be_an( Array )
        expect( convert.first ).to be_a( String )
      end
    end

    describe '#convert!' do
      it 'writes out the data to a file' do
        expect( special_converter ).to receive(:convert!)

        list = Suds.new(special_interpreter)
        list.add_converter special_converter
        list.convert!
      end
    end
  end

end
