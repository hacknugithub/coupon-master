class CouponBooksController < ApplicationController
  before_action :set_coupon_book, only: [:show, :update, :destroy]

  # GET /coupon_books
  def index
    @coupon_books = CouponBook.all

    render json: @coupon_books
  end

  # GET /coupon_books/1
  def show
    render json: @coupon_book
  end

  # POST /coupon_books
  def create
    @coupon_book = CouponBook.new(coupon_book_params)

    if @coupon_book.save
      render json: @coupon_book, status: :created, location: @coupon_book
    else
      render json: @coupon_book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /coupon_books/1
  def update
    if @coupon_book.update(coupon_book_params)
      render json: @coupon_book
    else
      render json: @coupon_book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /coupon_books/1
  def destroy
    @coupon_book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon_book
      @coupon_book = CouponBook.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def coupon_book_params
      params.require(:coupon_book).permit(:title, :max_number_of_coupons, :max_coupons_per_user)
    end
end
