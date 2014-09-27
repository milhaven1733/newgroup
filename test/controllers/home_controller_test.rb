require 'test_helper'

describe HomeController do

  it "search should search name & desc & category_name & Case-insensitive" do
    category = create(:category)
    create(:ticket, category: category, name: 'somethings')
    create(:ticket, category: category,  desc: 'Somethings' * 5)
    create(:ticket, category: create(:category, name: 'soMethings'))
    create(:ticket, category: category, name: 'nothings')
    get :search, { query: 'some' }
    assert_response :success
    assert_equal 3, assigns(:tickets).size
  end
end