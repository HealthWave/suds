require 'spec_helper'
require 'interpreter'

describe Interpretor do
  subject { Interpretor.new }

  context "interface" do
    it { should respond_to :data }
    it { should respond_to :headers }
  end
end
