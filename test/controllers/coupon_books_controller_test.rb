require "test_helper"

class CouponBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coupon_book = coupon_books(:one)
  end

  test "should get index" do
    get coupon_books_url, as: :json
    assert_response :success
  end

  test "should create coupon_book" do
    assert_difference('CouponBook.count') do
      post coupon_books_url, params: { coupon_book: { max_coupons_per_user: @coupon_book.max_coupons_per_user, max_number_of_coupons: @coupon_book.max_number_of_coupons, title: @coupon_book.title } }, as: :json
    end

    assert_response 201
  end

  test "should show coupon_book" do
    get coupon_book_url(@coupon_book), as: :json
    assert_response :success
  end

  test "should update coupon_book" do
    patch coupon_book_url(@coupon_book), params: { coupon_book: { max_coupons_per_user: @coupon_book.max_coupons_per_user, max_number_of_coupons: @coupon_book.max_number_of_coupons, title: @coupon_book.title } }, as: :json
    assert_response 200
  end

  test "should destroy coupon_book" do
    assert_difference('CouponBook.count', -1) do
      delete coupon_book_url(@coupon_book), as: :json
    end

    assert_response 204
  end
end
