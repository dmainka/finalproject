class CartItem < ActiveRecord::Base

  belongs_to :user#, :dependent => destroy
  belongs_to :product   #no dependent destroy as I don't allow a product to be destroyed if referenced by CartItem or OrderItem

  validates :quantity, numericality: { only_integer: true, :greater_than_or_equal_to =>0 }

end
