require "test_helper"

describe Adress do
  let(:adress) { Adress.new }

  it "must be valid" do
    adress.must_be :valid?
  end
end
