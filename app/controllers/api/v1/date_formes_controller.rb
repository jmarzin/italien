module Api
  module V1
    class DateFormesController < ApplicationController
      def index
        date = Forme.maximum("updated_at")
        render json: date.to_s
      end
    end
  end
end