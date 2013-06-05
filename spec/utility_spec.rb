require 'utility'

describe Utility do
  include Utility

  it "returns the min value" do
    min(1, 2).should == 1
  end

  it "returns the max value" do
    max(1, 2).should == 2
  end
end
