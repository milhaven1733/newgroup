require 'rails_helper'

RSpec.describe Mine::TicketsController, :type => :controller do
  let(:merchant) { FactoryGirl.create(:merchant)}

  before do
    sign_in merchant
  end

  describe 'GET new' do
    it 'should be success' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    it 'should success without student discount' do
      category = FactoryGirl.create(:category)
      post :create, ticket: { name: 'Cat', city: 'NewYork', category_id: category.id,
            description: 'abc', start_at: '2014/11/07 15:00', end_at: '2014/11/07 16:00',
            amount: 100, minimum_amount: 6, shipping: 0, oprice: 100 }
      response.should redirect_to(action: :show, id: assigns(:ticket).id)
    end

    #it 'should success with price tier' do
      #category = FactoryGirl.create(:category)
      #post :create, ticket: { name: 'Cat', city: 'NewYork', category_id: category.id,
            #description: 'abc', start_at: '2014/11/07 15:00', end_at: '2014/11/07 16:00',
            #amount: 100, minimum_amount: 6, shipping: 0, oprice: 100,
            #group_prices_attributes: {'0' => {range_from: 100, range_to: 200, discount: 10},
                          #'1' => {range_from: 300, range_to: 400, discount: 20}}}
      #response.should redirect_to(action: :show, id: assigns(:ticket).id)
    #end
  end
end
