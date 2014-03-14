module CartItemsHelper

  def cart_count
    session[:cart_count] = CartItem.where("user_id = ?", current_user).sum(:quantity)
  end

end
