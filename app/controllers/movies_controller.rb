class MoviesController < ApplicationController
  before_action :set_id, except:[:new,:create,:index]
  before_action :get_toprated, only:[:index]
  before_action :get_topviewed, only:[:index]

  def show
    @movies_list = Movie.all.order('rating desc')
  end

  def index
    @movies = Movie.all.first(3)
    @movies_toprated = @movies_toprated.limit(6)
    @movies_topviewed = @movies_topviewed.limit(6)
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

  def get_toprated
    @movies_toprated = Movie.all.order('rating desc')
  end

  def get_topviewed
    @movies_topviewed = Movie.all.order('rating asc')
  end

end
