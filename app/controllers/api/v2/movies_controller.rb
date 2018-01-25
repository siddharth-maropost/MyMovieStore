module Api
  module V2
    class MoviesController < ApplicationController
      before_action :authenticate_user!, except:[:movies_all, :movies_by_id, :search_movie_by_title]
      before_action :restrict_access

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

      

      private
        def restrict_access
          api_key = ApiKey.find_by_access_token(params[:access_token])
          head :unauthorized unless api_key
        end
    end
  end
end
