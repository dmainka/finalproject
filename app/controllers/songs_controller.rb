class SongsController < ApplicationController

  before_action :set_song, only: [:show, :edit, :update, :destroy]

  def index
    #the following doesn't work as it needs a collection of products
    # @songs = Song.all.paginate(page: params[:page], :per_page => 10)
    department_id = Department.find_by(:name => 'Songs')
    @songs = Product.search(params[:search]).where("department_id = ?", department_id).paginate(page: params[:page], :per_page => 10)
  end

  def show
    @product = Product.find(@song.product_id)
  end

   private

    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:product_id, :artist, :album, :time, :snippet_url)
    end

end
