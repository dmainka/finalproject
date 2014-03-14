class Song < Product

  belongs_to :product, :dependent => :destroy

end
