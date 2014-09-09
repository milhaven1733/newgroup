require "test_helper"

describe Transaction do
  let(:transaction) { Transaction.new }

  it "must be valid" do
    transaction.must_be :valid?
  end
end
