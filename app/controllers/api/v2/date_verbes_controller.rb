module Api
  module V2
    class DateVerbesController < ApplicationController
      def index
        date = Verbe.maximum("updated_at")
        render json: date.to_s
      end
    end
  end
end