require 'spec_helper'

describe Comment do
  
  context "validations" do
    it { should validate_presence_of(:text) }
  end

  context "associations" do
    it { should belong_to(:event) }
    it { should belong_to(:author).class_name("User") }
    it { should belong_to(:parent).class_name("Comment") }
    it { should have_many(:replies).class_name("Comment").with_foreign_key(:parent_id) }
  end
end