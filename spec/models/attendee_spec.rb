require 'spec_helper'

describe Attendee do
  it { should belong_to(:user) }
end