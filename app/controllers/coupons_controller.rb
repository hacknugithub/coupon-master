class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :update, :destroy, :validate_coupon]

  # GET /coupons
  def index
    @coupons = Coupon.all

    render json: @coupons
  end

  # GET /coupons/1
  def show
    render json: @coupon
  end

  # POST /coupons
  def create
    @coupon = Coupon.new(coupon_params)

    if @coupon.save
      render json: @coupon, status: :created, location: @coupon
    else
      render json: @coupon.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /coupons/1
  def update
    if @coupon.update(coupon_params)
      render json: @coupon
    else
      render json: @coupon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /coupons/1
  def destroy
    @coupon.destroy
  end

  def validate_coupon
    if @coupon.redeemed? || @coupon.nil?
      render json: {message: "This coupon is invalid or it has already been redeemed!"}, status: :unprocessable_entity
    else
      # Determine if the coupon is already assigned to the user
      user = @coupon.user_id.nil? ? User.find(params[:user_id]) : @coupon.user 
      # if not then find the user and assign the coupon

      if user.coupons.count < @coupon.coupon_book.max_coupons_per_user
        @coupon.update(user_id: user.id)
      else
        render json: {message: "Sorry you have reached the limit of coupons to redeem"}, status: :unprocessable_entity
      end

      current_cart = user.carts.last
      current_cart.apply_discount(@coupon)
      render json: {message: "The coupon is valid congrats, please finish the purchase to apply your discount!"}, status: :ok
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find_by(code: params[:code])
      @coupon = Coupon.find(id: params[:id]) if @coupon.nil?
    end

    # Only allow a list of trusted parameters through.
    def coupon_params
      params.require(:coupon).permit(:title, :code, :redeemed, :discount_percentage, :coupon_book_id)
    end
end
