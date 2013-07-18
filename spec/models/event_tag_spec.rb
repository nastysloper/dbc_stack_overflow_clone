require 'spec_helper'

describe EventTag do

  context "associations" do
    it { should belong_to(:tag) }
    it { should belong_to(:event) }
  end

end