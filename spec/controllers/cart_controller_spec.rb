require 'rails_helper'

RSpec.describe CartsController, type: :controller do

  context "GET /index" do
    let(:user) { FactoryBot.create(:user) }
    let(:cart) { FactoryBot.create(:cart, user_id: user.id) }
    it "returns ok" do
      get :index
      expect(response).to be_successful
    end
  end

  context "GET /purchase" do
    let(:user) { FactoryBot.create(:user) }
    let(:product) { FactoryBot.create(:product) }
    let(:cart) { FactoryBot.create(:cart, user_id: user.id) }
    let(:cart_item) { FactoryBot.create(:cart_item, product: product, cart: cart) }

    before do
      FactoryBot.create(:coupon_book)
    end

    it "completes the purchase and generates a valid coupon assigned to user" do
      get :purchase, params: {id: cart.id}
      expect(response).to be_successful

      cart.reload
      expect(cart.purchased).to eq(true)
      expect(Coupon.all.count).to eq(1)
    end

    it "respond with error when trying to complete an already purchased cart" do
      cart.update(purchased: true)
      get :purchase, params: {id: cart.id}
      
      expect(response).to be_unprocessable
      expect(Coupon.all.count).to eq(1)
    end

    it "does not generate a new coupon when the coupon limit has been reached" do
      coupon_book = CouponBook.last
      coupon_book.update(max_number_of_coupons: 1)
      get :purchase, params: {id: cart.id}

      expect(response).to be_successful
      expect(Coupon.all.count).to eq(1)
    end
  end
end