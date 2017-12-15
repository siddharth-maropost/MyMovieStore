class MoviesController < ApplicationController
  before_action :set_id, except:[:new,:create,:index]

  def show
    @movies_list = Movie.all.order('rating desc')
  end

  def index
    @movies = Movie.all.first(3)
    @movies_toprated = Movie.all.order('rating desc').limit(6)
    @movies_topviewed = Movie.all.order('rating asc').limit(6)
  end
  def edit

  end

  def new
    @movies = Movie.new
  end
  def create
    @movie = Movie.new(allowed_params)
    if @movie.save
      redirect_to @movie
    else
      render 'new'
    end

  end

  private
  def allowed_params
    params.require(:movie).permit(:title, :genre, :plot, :rating, :web, :image, :year, :cast)
  end
  def set_id
    @movies = Movie.find(params[:id])
  end

end
