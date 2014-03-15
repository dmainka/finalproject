class OrdersController < ApplicationController

  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    # @orders = Order.all
    @orders = Order.where("user_id = ?", current_user).order("order_date DESC").paginate(page: params[:page], :per_page => 10)
  end

  def show
  end

  def new
    #normally not strictly necessary as Checkout button wouldn't be on screen if no items
    #but trying to ensure we don't get here some other way
    cart_items = CartItem.where("user_id = ?", current_user);
    if cart_items.count == 0
      redirect_to products_path, :notice => "Your cart is empty."
      return
    end

    @order = Order.new
  end

  def create

    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.order_date = Time.zone.now

    cart_items = CartItem.where("user_id = ?", current_user);
    @order.total = BigDecimal("0.00")
    cart_items.each do |cart_item|
      @order.total += Product.find(cart_item.product_id).price * BigDecimal(cart_item.quantity)
    end

    if @order.save
      # get all cart items for current_user
      cart_items.each do |cart_item|
        order_item = OrderItem.new
        order_item.order_id = @order.id
        order_item.product_id = cart_item.product_id
        order_item.quantity = cart_item.quantity
        cart_item.destroy
        order_item.save
      end
      UserMailer.order_received(@order).deliver
      flash[:success] = "Order #{@order.id} successfully created!  Order confirmation sent as well."
      redirect_to orders_path
    else
      render 'new'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :order_date, :total, :ship_to_name, :ship_to_address, :payment_type)
    end

    # Before filters

    def correct_user
      order = Order.find(params[:id])
      user = User.find(order.user_id)
      if (!current_user?(user))
        flash[:notice] = "Nice try!"
        redirect_to orders_path
      end
    end

end
