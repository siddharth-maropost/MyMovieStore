module Api
  module V1
    class MoviesController < ApplicationController
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
