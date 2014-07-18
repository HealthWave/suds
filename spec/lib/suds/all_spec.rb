require 'spec_helper'
require 'suds/all'

describe "all requires" do
  it { JSONConverter }
  it { CSVInterpreter }
  it { FileInterpreter }
  it { ColumnConverterCleaner }
  it { ColumnFilterCleaner }
  it { DowncaseCleaner }
  it { RegexCleaner }
  it { WhitespaceCleaner }
end