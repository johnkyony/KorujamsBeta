require "test_helper"

describe PayDepositsController do
  it "should get new" do
    get :new
    value(response).must_be :success?
  end

  it "should get create" do
    get :create
    value(response).must_be :success?
  end

end
