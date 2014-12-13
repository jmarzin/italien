module Api
  module V2
    class FormesController < ApplicationController
      def index
        render json: Forme.api_v2
      end
    end
  end
end