class ProductsController < ApplicationController

  before_action :set_product, only: [:show]

  def index
    @products = Product.search(params[:search]).paginate(page: params[:page], :per_page => 10)
  end

  def show
    department = Department.find(@product.department_id)
    case department.name
      when "Books"
        # flash[:success] = "Found your book"
        book = Book.find_by(:product_id => @product.id)
        redirect_to book_path(book.id)
      when "Songs"
        # flash[:success] = "Found your song"
        song = Song.find_by(:product_id => @product.id)
        redirect_to song_path(song.id)
      else
        flash[:notice] = "Only found a generic product #{department.name}"
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:vendor_id, :name, :description, :price, :image_url, :department_id)
    end

end
