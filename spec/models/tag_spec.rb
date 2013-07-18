require 'spec_helper'

describe Tag do

  context "validations" do
    it { should validate_presence_of(:name) }
  end

  context "associations" do
    it { should have_many(:event_tags) }
    it { should have_many(:events).through(:event_tags) }
  end

end