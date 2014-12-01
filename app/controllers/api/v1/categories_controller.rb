module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        render json: Category.api_v1
      end
    end
  end
end