module Api
  module V2
    class MotsController < ApplicationController
      def index
        render json: Mot.api_v2
      end
    end
  end
end