require 'spec_helper'
require 'suds/cleaner/regex_cleaner'

describe RegexCleaner do
  subject { RegexCleaner }

  context 'constants' do
    it "has a regex constant for emails" do
      expect(subject).to be_const_defined(:EMAIL_REGEX)
    end
  end


  describe "#initialize" do
    it 'accepts a hash that maps column names to regexes' do
      subject.new({name: /uri/})
    end

    it 'accepts arrays mapped to regular expressions' do
      cleaner = subject.new({[:first_name, :last_name] => /uri/})
      expect(cleaner.instance_variable_get(:@columns)).to eq(%w[first_name last_name])
    end

    it 'accepts a hash that decides whether or not to delete the entire row' do
      subject.new({name: /uri/}, destroy_row: true)
    end
  end

  describe "#clean" do
    let(:bad_data) { [{email: "uri"}] }
    let(:good_data) { [{email: "uri@healthwave.co"}] }
    let(:cleaner) { subject.new({email: subject::EMAIL_REGEX}) }


    it 'keeps columns if they match the regex' do
      results = cleaner.clean good_data
      expect(results.first.keys).to include(:email)
    end

    it 'removes columns if they do not match the regex' do
      results = cleaner.clean bad_data
      expect(results.first.keys).to_not include(:email)
    end

    it "destroys rows if the regex doesn't match" do
      cleaner =  subject.new({email: subject::EMAIL_REGEX}, destroy_row: true)
      results = cleaner.clean bad_data
      expect(results).to be_empty
    end

  end
end
