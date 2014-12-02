module Api
  module V1
    class DateCategoriesController < ApplicationController
      def index
        date = Category.maximum("updated_at")
        render json: date.to_s
      end
    end
  end
end