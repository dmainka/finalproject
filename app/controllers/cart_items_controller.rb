class CartItemsController < ApplicationController

  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy]

  def index
    @back_url = session[:my_previous_url]
    @cart_items = CartItem.where("user_id = ?", current_user)
  end

  def show
    cart_item = CartItem.find(params[:id])
    render cart_item
  end

  def edit
  end

  def create
    # Save prior location for Continue Shopping button
    session[:last_product_page] = request.env['HTTP_REFERER'] || products_path

    # get all cart items for current_user
    cart_items = CartItem.where("user_id = ?", current_user);

    cart_item = cart_items.where(:product_id => params[:product_id]).first
    if (cart_item)
      cart_item.quantity += 1
      cart_item.save
    else
      cart_item = CartItem.new
      cart_item.user_id = current_user.id
      cart_item.product_id = params[:product_id]
      cart_item.save
    end

    redirect_to(cart_items_path, :notice => "Item was successfully added to your cart.")
  end

  def update
    if @cart_item.update_attributes(cart_item_params)
      flash[:success] = "Quantity updated"
      if (@cart_item.quantity <= 0)
        @cart_item.destroy
      end
      redirect_to cart_items_path
    else
      render 'edit'
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to(cart_items_path, :notice => "Item was successfully deleted from your cart.")
  end

  def continue_shopping
    redirect_back_or(products_path)
  end

  def empty_cart
    cart_items = CartItem.where("user_id = ?", current_user);

    cart_items.each do |cart_item|
      cart_item.destroy
    end

    redirect_to(cart_items_path, :notice => "Cart was successfully emptied.")
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_item_params
      params.require(:cart_item).permit(:user_id, :product_id, :quantity)
    end

    # Before filters

    def correct_user
      cart_item = CartItem.find(params[:id])
      user = User.find(cart_item.user_id)
      if (!current_user?(user))
        flash[:notice] = "Nice try!"
        redirect_to cart_items_path
      end
    end

end
