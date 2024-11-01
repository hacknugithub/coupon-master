require "test_helper"

class CouponsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coupon = coupons(:one)
  end

  test "should get index" do
    get coupons_url, as: :json
    assert_response :success
  end

  test "should create coupon" do
    assert_difference('Coupon.count') do
      post coupons_url, params: { coupon: { code: @coupon.code, discount_percentage: @coupon.discount_percentage, redeemed: @coupon.redeemed, title: @coupon.title } }, as: :json
    end

    assert_response 201
  end

  test "should show coupon" do
    get coupon_url(@coupon), as: :json
    assert_response :success
  end

  test "should update coupon" do
    patch coupon_url(@coupon), params: { coupon: { code: @coupon.code, discount_percentage: @coupon.discount_percentage, redeemed: @coupon.redeemed, title: @coupon.title } }, as: :json
    assert_response 200
  end

  test "should destroy coupon" do
    assert_difference('Coupon.count', -1) do
      delete coupon_url(@coupon), as: :json
    end

    assert_response 204
  end
end