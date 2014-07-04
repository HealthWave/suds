require 'suds/cleaner'

class WhitespaceCleaner
  def self.clean data, options={}
    Cleaner.clean_array(data) do |_,v|
      v.strip! if v
    end
  end
end
