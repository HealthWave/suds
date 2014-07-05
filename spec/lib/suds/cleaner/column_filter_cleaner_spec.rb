require 'spec_helper'
require 'suds/cleaner/column_filter_cleaner'

describe ColumnFilterCleaner do
  subject { ColumnFilterCleaner }

  describe '#initialize' do

    it 'raises an error if both exclude and include columns are not present or empty' do
      error_reg = /You must provide include_columns or exclude_columns./
      expect{ subject.new }.to raise_error(error_reg)
      expect{ subject.new include_columns: [] }.to raise_error(error_reg)
      expect{ subject.new exclude_columns: [] }.to raise_error(error_reg)
      expect{ subject.new include_columns: [], exclude_columns: [] }.to raise_error(error_reg)
    end

    it 'makes include columns publicly available' do
      cleaner = subject.new include_columns: [{}]
      expect(cleaner).to respond_to(:include_columns)
    end

    it 'makes exclude columns publicly available' do
      cleaner = subject.new exclude_columns: [{}]
      expect(cleaner).to respond_to(:exclude_columns)
    end
  end

  describe '#clean' do
    let(:data) { [{row1: 'a', row2: 'b'}] }
    let(:original_data) { data.clone }

    it 'excludes certain columns' do
      cleaner = subject.new exclude_columns: :row2
      result = cleaner.clean data
      expect(result.first.keys).to include(:row1)
      expect(result.first.keys).to_not include(:row2)
    end

    it 'only includes the listed columns' do
      cleaner = subject.new include_columns: :row2
      result = cleaner.clean data
      expect(result.first.keys).to_not include(:row1)
      expect(result.first.keys).to include(:row2)
    end

    it 'accepts both strings and symbol arrays' do
      cleaner = subject.new include_columns: "row2"
      result = cleaner.clean data
      expect(result.first.keys).to_not include(:row1)
      expect(result.first.keys).to include(:row2)

    end
  end


end
