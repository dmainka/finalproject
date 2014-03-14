require 'spec_helper'

describe Vendor do

  before { @vendor = Vendor.new(name: "Vendor1", rating: 1) }

  subject { @vendor }

  it { should respond_to(:name) }
  it { should respond_to(:rating) }

  it { should be_valid }

  describe "when name is not present" do
    before { @vendor.name = " " }
    it { should_not be_valid }
  end

end
