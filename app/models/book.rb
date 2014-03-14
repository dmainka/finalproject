class Book < Product

  belongs_to :product, :dependent => :destroy

end
