require 'spec_helper'

describe Vote do

  context "associations" do
    it { should belong_to(:comment) }
    it { should belong_to(:voter).class_name("User") }
  end

end