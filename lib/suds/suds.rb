require 'suds/interpreter'
require 'suds/cleaner'
require 'suds/converter'

class Suds

  attr_accessor :interpreter, :cleaners, :converters, :data

  def initialize interpreter
    @interpreter = interpreter
    @converters = []
    @cleaners = []
  end

  def add_converter converter
    raise "#{converter.class} is not a valid Converter." unless converter.is_a?(Converter)
    @converters << converter
  end

  def add_cleaner cleaner
    raise "#{cleaner.class} is not a valid Cleaner." unless cleaner.is_a?(Cleaner)
    @cleaners << cleaner
  end

  def clean
    @data = @cleaners.inject(interpreter.data) do |data,cleaner|
      data = cleaner.clean data
    end
  end

  def convert!
    @converters.each { |converter| converter.convert! data}
  end

  def convert
    @converters.map { |converter| converter.convert data}
  end

  def raw_data
    interpreter.data
  end

  def data
    @data ||= interpreter.interpret
  end
end
