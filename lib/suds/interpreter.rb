
class Interpretor
  attr_accessor :headers, :data

  def initialize
    @headers = []
    @data = []
  end


  def interpret
    raise "No interpretation defined."
  end

  def data
    interpret if @data.nil? || @data.empty?
    @data
  end
end
