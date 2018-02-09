require "test_helper"

describe PersonalMessage do
  let(:personal_message) { PersonalMessage.new }

  it "must be valid" do
    value(personal_message).must_be :valid?
  end
end
