require 'csv'
require 'suds/interpreter'

class CSVInterpreter < Interpreter
  attr_accessor :filepath

  def initialize raw_data
    @raw_data = raw_data
    super()
  end


  def interpret
    CSV.parse(@raw_data, headers: true, header_converters: :symbol).each do |row|
      @headers = row.headers if @headers.nil? || @headers.empty?
      interpret_unit row
    end
    @data
  end

  def interpret_unit unit
    raise "Headers have not be set." if @headers.empty?
    raise "Invalid data for current headers." if @headers.size != unit.size

    @data << unit.to_h
  end

end
