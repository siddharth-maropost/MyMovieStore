class MoviesController < ApplicationController
  before_action :set_id, except:[:new,:create,:index]

  def show
  end

  def new
    @movie = Movie.new
  end
  def create
    @movie = Movie.new(allowed_params)
    if @movie.save
      redirect_to "show"
    else
      render 'new'
    end

  end

  private
  def allowed_params
    params.require(:movie).permit(:title, :genre, :plot, :rating, :web, :image)
  end
  def set_id
    @movies = Movie.find(params[:id])
  end

end
