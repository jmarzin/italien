module Api
  module V1
    class DateVerbesController < ApplicationController
      def index
        date = Verbe.maximum("updated_at")
        render json: date.to_s
      end
    end
  end
end