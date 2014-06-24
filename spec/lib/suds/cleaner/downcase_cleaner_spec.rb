require 'spec_helper'
require 'cleaner/downcase_cleaner'

describe DowncaseCleaner do
  include_context "shared cleaner"
  subject { DowncaseCleaner }

  let(:data) { {a: "   Test", b: "Double test   "} }
  # let!(:original_value) { data.first.last.clone }

  # it "downcases an array of objects" do
  #expect(   modified_value ).to match /[^A-Z]/
  # end

end
