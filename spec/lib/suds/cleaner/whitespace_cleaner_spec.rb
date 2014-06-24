require 'spec_helper'
require 'cleaner/whitespace_cleaner'

describe WhitespaceCleaner do
  include_context "shared cleaner"
  subject { WhitespaceCleaner }

  let(:data) { {a: "   Test", b: "Double test   "} }
  # let!(:original_value) { data.first.last.clone }

  # it "downcases an array of objects" do
  #expect(   modified_value ).to match /^[^\s].+[^\s]$/
  # end

end
