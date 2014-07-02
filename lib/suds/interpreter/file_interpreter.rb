
class FileInterpreter < Interpreter
  def initialize filepath
    # TODO File validation
    @raw_data = open(filepath, 'r').read
  end

  def interpret
    @data = @raw_data
  end
end
