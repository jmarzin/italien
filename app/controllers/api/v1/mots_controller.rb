module Api
  module V1
    class MotsController < ApplicationController
      def index
        render json: Mot.api_v1
      end
    end
  end
end