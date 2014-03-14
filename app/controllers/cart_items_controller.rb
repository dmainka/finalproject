class CartItemsController < ApplicationController

  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy]

  # GET /cart_items
  # GET /cart_items.json
  def index
    @cart_items = CartItem.where("user_id = ?", current_user).paginate(page: params[:page], :per_page => 10)
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show
    cart_item = CartItem.find(params[:id])
    render cart_item
  end

  # # GET /cart_items/new
  # def new
  #   @cart_item = CartItem.new
  # end

  # GET /cart_items/1/edit
  def edit
  end

  # POST /cart_items
  # POST /cart_items.json
  def create
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

    # @cart_item = CartItem.new(cart_item_params)

    # respond_to do |format|
    #   if @cart_item.save
    #     format.html { redirect_to @cart_item, notice: 'Cart item was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @cart_item }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @cart_item.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
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

    # respond_to do |format|
    #   if @cart_item.update(cart_item_params)
    #     format.html { redirect_to @cart_item, notice: 'Cart item was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: 'edit' }
    #     format.json { render json: @cart_item.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cartItem.destroy
    redirect_to(cart_items_path, :notice => "Item was successfully deleted from your cart.")

    # @cart_item.destroy
    # respond_to do |format|
    #   format.html { redirect_to cart_items_url }
    #   format.json { head :no_content }
    # end
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
