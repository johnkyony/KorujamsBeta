require "test_helper"

describe DepositPaid do
  let(:deposit_paid) { DepositPaid.new }

  it "must be valid" do
    value(deposit_paid).must_be :valid?
  end
end
