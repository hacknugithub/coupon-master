require 'rails_helper'

RSpec.describe CouponsController, type: :controller do

  context "GET /index" do
    let(:coupon_book) { FactoryBot.create(:coupon_book) }
    let(:user) { FactoryBot.create(:user) }
    let(:cart) { FactoryBot.create(:cart, user_id: user.id) }
    let(:coupon) { FactoryBot.create(:coupon, user_id: user.id, coupon_book_id: coupon_book.id) }

    it "returns ok" do
      get :index
      expect(response).to be_successful
    end
  end

  context "GET /validate_coupon" do
    let(:coupon_book) { FactoryBot.create(:coupon_book) }
    let(:user) { FactoryBot.create(:user) }
    let(:product) { FactoryBot.create(:product) }
    # let(:cart) { FactoryBot.create(:cart, user_id: user.id) }
    let(:cart_item) { FactoryBot.create(:cart_item, product_id: product.id, cart_id: cart.id) }
    let(:assigned_coupon) { FactoryBot.create(:coupon, user_id: user.id, coupon_book_id: coupon_book.id) }
    let(:unassigned_coupon) { FactoryBot.create(:coupon, user_id: nil, coupon_book_id: coupon_book.id) }
    let(:redeemed_coupon) { FactoryBot.create(:coupon, user_id: user.id, coupon_book_id: coupon_book.id, redeemed: true) }
    let(:extra_coupon) { FactoryBot.create(:coupon, user_id: user.id, coupon_book_id: coupon_book.id) }

    before do
      FactoryBot.create(:cart, user_id: user.id)
    end

    it "applies a valid coupon to a cart linked to a user with assigned coupon" do
      get :validate_coupon, params: {code: assigned_coupon.code, user_id: user.id}
      expect(response).to be_successful

      cart = Cart.last
      assigned_coupon.reload
      expect(cart.discount_total).not_to be_nil
      expect(assigned_coupon.redeemed).to eq(true)
    end

    it "applies a valid coupon to a cart linked to a user with unassigned coupon" do
      get :validate_coupon, params: {code: unassigned_coupon.code, user_id: user.id}
      expect(response).to be_successful

      cart = Cart.last
      unassigned_coupon.reload
      expect(cart.discount_total).not_to be_nil
      expect(unassigned_coupon.redeemed).to eq(true)
      expect(unassigned_coupon.user_id).to eq(user.id)
    end

    it 'should error with an already redeemed coupon' do
      get :validate_coupon, params: {code: redeemed_coupon.code, user_id: user.id}
      expect(response).to be_unprocessable
    end

    it 'should error if the user reaches the limit of coupons' do
      coupon_book.update(max_coupons_per_user: 1)
      get :validate_coupon, params: {code: extra_coupon.code, user_id: user.id}
      expect(response).to be_unprocessable
    end
  end
end