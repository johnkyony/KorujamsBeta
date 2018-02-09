require "test_helper"

describe Conversation do
  let(:conversation) { Conversation.new }

  it "must be valid" do
    value(conversation).must_be :valid?
  end
end
