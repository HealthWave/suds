require 'spec_helper'
require 'interpreter'

describe Interpreter do
  subject { Interpreter.new }

  context "interface" do
    it { should respond_to :data }
    it { should respond_to :headers }
  end
end
