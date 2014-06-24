
class Cleaner
  attr_accessor :data, :action

  def initialize &b
    block_given? ? @action = b : raise("The generic Cleaner must be provided a block.")
  end

  def self.clean_array array, &b
    raise "Please provide either a hash or an array as the main parameter" unless Array === array
    array.each do |row|
      clean_hash row, &b
    end
    return array
  end

  def self.clean_hash hash, &b
    raise "Please provide either a hash or an array as the main parameter" unless Hash === hash

    hash.each do |k,v|
      b.call(k,v)
    end
    return hash
  end

  def clean data
    @data = data
    self.class.clean_array(@data) do |k,v|
      @action.call(k,v)
    end
  end
end
