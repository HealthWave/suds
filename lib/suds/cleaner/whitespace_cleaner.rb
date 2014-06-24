require 'suds/cleaner'

class WhitespaceCleaner
  def self.clean data, options={}
    Cleaner.clean_array(data) do |_,v|
      v.strip!
    end
  end
end
