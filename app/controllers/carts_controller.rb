class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :update, :destroy, :purchase]
  after_action :create_coupon_after_purchase, only: [:purchase]

  # GET /carts
  def index
    @carts = Cart.all

    render json: @carts
  end

  # GET /carts/1
  def show
    render json: @cart
  end

  # POST /carts
  def create
    @cart = Cart.new(cart_params)

    if @cart.save
      render json: @cart, status: :created, location: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /carts/1
  def update
    if @cart.update(cart_params)
      render json: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # DELETE /carts/1
  def destroy
    @cart.destroy
  end

  def purchase
    if @cart.purchased?
      render json: {message: 'This coupon has already been redeemed'}, status: :unprocessable_entity
    else
      @cart.coupon.update(redeemed: true) if @cart.coupon.present?
      @cart.update!(purchased: true)
      render json: {message: 'Congrats the purchased is completed'}, status: :ok
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:total)
    end

    def create_coupon_after_purchase
      # Make this into a setting or maybe add a field to determine the duration of the coupon book
      # so you can filter by the active or current coupon book EG. Fall season vs Christmass
      coupon_book = CouponBook.last
      # Make sure that the user does not have more coupons than he suppoused to have
      user_id = @cart.user.coupons.count < coupon_book.max_coupons_per_user ? @cart.user.id : nil

      # Check if the current number of coupons allows to create a new one
      if coupon_book.coupons.count < coupon_book.max_number_of_coupons 
        Coupon.create_coupon(user_id, coupon_book, @cart.total)
      end
    end
end
