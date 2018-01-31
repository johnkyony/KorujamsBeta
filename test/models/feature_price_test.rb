require "test_helper"

describe FeaturePrice do
  let(:feature_price) { FeaturePrice.new }

  it "must be valid" do
    value(feature_price).must_be :valid?
  end
end
