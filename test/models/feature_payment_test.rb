require "test_helper"

describe FeaturePayment do
  let(:feature_payment) { FeaturePayment.new }

  it "must be valid" do
    value(feature_payment).must_be :valid?
  end
end
