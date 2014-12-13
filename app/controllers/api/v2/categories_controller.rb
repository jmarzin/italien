module Api
  module V2
    class CategoriesController < ApplicationController
      def index
        render json: Category.api_v2
      end
    end
  end
end