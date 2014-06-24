require 'json'
require 'suds/converter'

class JSONConverter < Converter
  def convert data
    self.converted_data = data.to_json
  end
end
