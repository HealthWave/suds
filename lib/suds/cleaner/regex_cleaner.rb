require 'suds/cleaner'

class RegexCleaner < Cleaner
  attr_accessor :regex_map
  EMAIL_REGEX = /^[a-zA-Z0-9_.+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+$/

  def initialize regex_map, destroy_row: false
    @regex_map = {}
    regex_map.each do |column,regex|
      if Array === column
        column.each do |col|
          @regex_map[col] = regex
        end
      else
        @regex_map[column] = regex
      end
    end
    @columns = @regex_map.keys.map(&:to_s)
    @destroy_row = destroy_row
  end

  def clean data
    ret_data = data.select do |row|
      save_row = true
      row.keys.each do |key|
        if @regex_map[key]
          if !(row[key].to_s =~ @regex_map[key])
            if @destroy_row
              save_row = false
            else
              row.delete key
            end
          end
        end
      end
      save_row # for select
    end
    return ret_data
  end

end
