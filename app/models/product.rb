class Product < ActiveRecord::Base

  before_destroy :ensure_not_referenced_by_any_cart_item

  belongs_to :department
  belongs_to :vendor
  has_many :cart_items
  has_many :order_items

  def Product.search(key)
    if (key)
      Product.where("name LIKE ?", "%#{key}%")
    else
      Product.all
    end
  end

  #ensure that there are no cart_items referencing this product
  def ensure_not_referenced_by_any_cart_item

    if cart_items.count.zero?
      return true
    else
      errors.add(:base, 'Cart Items present')
      return false
    end

  end

  #ensure that there are no order_items referencing this product
  def ensure_not_referenced_by_any_order_item

    if order_items.count.zero?
      return true
    else
      errors.add(:base, 'Order Items present')
      return false
    end

  end

end
