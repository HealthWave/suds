require 'csv'
require 'suds/interpreter'

class CSVInterpretor < Interpretor
  attr_accessor :filepath

  def initialize filepath
    @filepath = filepath
    super()
  end


  def interpret
    CSV.foreach(filepath, headers: true, header_converters: :symbol).each do |row|
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
