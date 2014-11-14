require "test_helper"

describe UserInfo do
  let(:user_info) { UserInfo.new }

  it "must be valid" do
    user_info.must_be :valid?
  end
end
