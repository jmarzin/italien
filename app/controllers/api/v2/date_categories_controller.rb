module Api
  module V2
    class DateCategoriesController < ApplicationController
      def index
        date = Category.maximum("updated_at")
        render json: date.to_s
      end
    end
  end
end