module Api
  module V1
    class FormesController < ApplicationController
      def index
        render json: Forme.api_v1
      end
    end
  end
end