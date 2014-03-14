class Department < ActiveRecord::Base

  has_many :products

  validates :name, presence: true, length: { maximum: 50 }

end
