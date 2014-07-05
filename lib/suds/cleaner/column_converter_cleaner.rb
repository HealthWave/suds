require 'suds/cleaner'

class ColumnConverterCleaner < Cleaner
  def initialize convert_hash, force_strings = false
    @force_strings = force_strings
    @convert_hash = convert_hash
  end

  def clean data
    data.each do |row|
      keys = row.keys
      keys.each do |key|
        if new_key = @convert_hash[key]
          old_value = row[key]
          row.delete key
          if @force_strings
            new_key = new_key.to_s
          else
            new_key = new_key.to_sym
          end
          row[new_key] = old_value
        end
      end
    end
  end
end
