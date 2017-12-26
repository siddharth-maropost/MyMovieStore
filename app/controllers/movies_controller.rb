class MoviesController < ApplicationController
  before_action :authenticate_admin_user!,only: [:create]
  before_action :set_id, except:[:index, :detail, :create]
  before_action :get_toprated, only:[:index, :detail]
  before_action :get_topviewed, only:[:index, :detail]

  def show
    @movies_list = Movie.all.order('rating desc').limit(9)
    @comments = Comment.all
    @limited_comments = @movies.comments.limit(3)

  end

  def index
    @movies = Movie.all.first(3)
    @movies_toprated = @movies_toprated.limit(6)
    @movies_topviewed = @movies_topviewed.limit(6)

    @movies_search = Movie.all
    if params[:search]
      @movies_search = Movie.search(params[:search]).order("created_at DESC")
    else
      @movies_search = Movie.all.order('created_at DESC')
    end
  end
  def detail

    @view = params[:view]
    @movies_toprated = @movies_toprated.search(params[:search])
    @movies_topviewed = @movies_topviewed.search(params[:search])

  end

  def edit

  end

  # def new
  #   @movies = Movie.new
  # end
  def create

    if params[:view] == "automatic"
      debugger
      @mv = OtherServiceCall.new.api_call(params[:movie][:title])
      if @mv == true
        redirect_to  "#{ Rails.application.secrets.url}/admin/movies", notice: "movie successfully saved"
      else
        redirect_to new_admin_movie_path(view: params[:view]), alert: "movie match failed, please verify"
      end
    else
      @movie = Movie.new(allowed_params)

      if @movie.save
        redirect_to admin_movie_path(@movie),notice: "movie Successfully Saved"
      else
        redirect_to new_admin_movie_path, alert: "make sure you have entered all the details"
      end
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
