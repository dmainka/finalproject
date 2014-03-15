class BooksController < ApplicationController

  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    #the following doesn't work as it needs a collection of products
    # @books = Book.all.paginate(page: params[:page], :per_page => 10)
    department_id = Department.find_by(:name => 'Books')
    @books = Product.search(params[:search]).where("department_id = ?", department_id).paginate(page: params[:page], :per_page => 10)
  end

  def show
    @product = Product.find(@book.product_id)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:product_id, :author, :pages)
    end

end
