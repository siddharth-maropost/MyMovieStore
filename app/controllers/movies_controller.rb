class MoviesController < ApplicationController

  before_action :authenticate_user!, except:[:index, :show, :create, :detail]
  before_action :set_id, except:[:index, :detail, :create, :api_key, :generate_api_key]
  before_action :get_toprated, only:[:index, :detail]
  before_action :get_topviewed, only:[:index, :detail]

  def show
    @movies_list = Movie.all.order('rating desc').limit(5)
    @comments = Comment.all
    @limited_comments = @movies.comments.limit(3)
    var = @movies.view + 1
    @movies.view = var
    @movies.save

  end

  def index
    @movies = Movie.all.order('created_at DESC')
    @movies_toprated = @movies_toprated.limit(6)
    @movies_topviewed = @movies_topviewed.limit(6)

    # @movies_search = Movie.all
    # if params[:search]
    #   @movies_search = Movie.search(params[:search]).order("created_at DESC")
    # else
    #   @movies_search = Movie.all.order('created_at DESC')
    # end
  end
  def detail


    if params[:search]
      @view = params[:view]
      @movies_toprated = @movies_toprated.search(params[:search])
      @movies_topviewed = @movies_topviewed.search(params[:search])

    else
      @view = params[:view]
      @movies_toprated = @movies_toprated
      @movies_topviewed = @movies_topviewed
    end

  end

  def edit

  end

  # def new
  #   @movies = Movie.new
  # end
  def create
    #check for redundancy of if movie exist or not all movie variable to pass in other service call
    @mv_exist = Movie.all

    if params[:view] == "automatic"
      if @mv_exist.find_by_title(params[:movie][:title])
        redirect_to new_admin_movie_path(view: params[:view]), notice: "movie already exist !!"
      else
        @mv = OtherServiceCall.new.api_call(params[:movie][:title])
        if @mv == true
          redirect_to  "#{ Rails.application.secrets.url}/admin/movies", notice: "movie successfully saved"
        else
          redirect_to new_admin_movie_path(view: params[:view]), alert: "movie match failed, please verify"
        end
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

  def api_key
    if params[:id]
      @key_record = ApiKey.find_by_id(params[:id])
      @access_token = @key_record.access_token
    else
      @key_record = ApiKey.find_by_user_id(current_user.id)
      if @key_record
        @access_token = @key_record.access_token
      else
      end
    end

  end

  def generate_api_key
    @api_exist = ApiKey.find_by_user_id(current_user.id)
    if @api_exist && ApiKey.find_by_user_id(current_user.id)
      redirect_to api_key_path(id: @api_exist.id)
    else
      @unique_key = ApiKey.new
      @unique_key.user_id = current_user.id
      if @unique_key.save
        Thread.new{
          ApiMailer.access_token_mail(current_user, @unique_key.access_token).deliver_now
        }
        redirect_to api_key_path(id: @unique_key.id)
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
    @movies_topviewed = Movie.all.order('view desc')
  end


end
