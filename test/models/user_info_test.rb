require "test_helper"

describe UserInfo do
  let(:user_info) { create(:user_info) }

  it "must be valid" do
    user_info.must_be :valid?
  end

end
