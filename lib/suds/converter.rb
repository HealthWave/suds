require 'fileutils'

class Converter
  attr_accessor :outfile, :converter, :converted_data

  def initialize outfile=nil, &b
    @outfile = outfile
    @converter = b
  end

  def convert data
    raise "A generic Converter can only convert with a block" unless @converter
    @converted_data = @converter.call(data)
  end

  def convert! data
    raise "Cannot output to file if outfile is not set." unless @outfile
    fname = File.expand_path(@outfile)
    dir = File.dirname fname

    if !File.directory?(dir)
      FileUtils.mkdir_p dir
    end

    File.open(fname, 'w').write(convert(data))
  end
end
