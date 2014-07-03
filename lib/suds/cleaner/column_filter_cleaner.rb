require 'suds/cleaner'

class ColumnFilterCleaner < Cleaner
  attr_accessor :exclude_columns, :include_columns
  def initialize exclude_columns:[], include_columns:[]
    @exclude_columns = [exclude_columns].flatten
    @include_columns = [include_columns].flatten

    raise "You must provide include_columns or exclude_columns." if @exclude_columns.empty? and @include_columns.empty?
  end

  def clean data
    if not @include_columns.empty?
      exclude_columns = data.first.keys - @include_columns
    else
      exclude_columns = @exclude_columns
    end

    data.each do |row|
      exclude_columns.each { |col| row.delete col }
    end
  end
end
