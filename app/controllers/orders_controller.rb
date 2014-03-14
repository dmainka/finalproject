class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    # @orders = Order.all
    @orders = Order.where("user_id = ?", current_user).order("order_date DESC").paginate(page: params[:page], :per_page => 10)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order_items = OrderItem.where("order_id = ?", @order.id)
  end

  # GET /orders/new
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

  # # GET /orders/1/edit
  # def edit
  # end

  # POST /orders
  # POST /orders.json
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
      flash[:success] = "Order #{@order.id} successfully created!"
      redirect_to orders_path
    else
      render 'new'
    end

    # @order = Order.new(order_params)

    # respond_to do |format|
    #   if @order.save
    #     format.html { redirect_to @order, notice: 'Order was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @order }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @order.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # # PATCH/PUT /orders/1
  # # PATCH/PUT /orders/1.json
  # def update
  #   respond_to do |format|
  #     if @order.update(order_params)
  #       format.html { redirect_to @order, notice: 'Order was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @order.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /orders/1
  # # DELETE /orders/1.json
  # def destroy
  #   @order.destroy
  #   respond_to do |format|
  #     format.html { redirect_to orders_url }
  #     format.json { head :no_content }
  #   end
  # end

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
