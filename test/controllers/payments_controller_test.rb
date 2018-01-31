require "test_helper"

describe PaymentsController do
  it "should get paid" do
    get :paid
    value(response).must_be :success?
  end

  it "should get success" do
    get :success
    value(response).must_be :success?
  end

  it "should get fail" do
    get :fail
    value(response).must_be :success?
  end

end
