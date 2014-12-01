module Api
  module V1
    class VerbesController < ApplicationController
      def index
        render json: Verbe.api_v1
      end
    end
  end
end