require "test_helper"

describe MerchantInfo do
  let(:merchant_info) { MerchantInfo.new }

  it "must be valid" do
    merchant_info.must_be :valid?
  end
end
