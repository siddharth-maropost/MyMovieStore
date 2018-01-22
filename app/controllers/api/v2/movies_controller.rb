module Api
  module V2
    class MoviesController < ApplicationController
      before_action :authenticate_user!, except:[:movies_all, :movies_by_id, :search_movie_by_title]
      respond_to :json

      def movies_all
        respond_with Movie.all
      end

      def movies_by_id
        respond_with Movie.find(params[:id])
      end


      def search_movie_by_title
        respond_with Movie.find_by_title(params[:title])
      end
    end
  end
end
