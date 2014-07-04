require 'suds/cleaner'

class ColumnConverterCleaner < Cleaner
  def initialize convert_hash, force_strings = true
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
          new_key = new_key.to_s if @force_strings
          row[new_key] = old_value
        end
      end
    end
  end
end
