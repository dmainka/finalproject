class Vendor < ActiveRecord::Base

  has_many :products

  validates :name, presence: true, length: { maximum: 50 }
  validates_numericality_of :rating, :only_integer => true, :allow_nil => true,
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 5,
    :message => "can only be whole number between 0 and 5."

end
