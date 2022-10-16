module Api
  class DeliveriesController < ApplicationController
    def index
      deliveries = Delivery.arel_table
      @deliveries = Delivery.where(deliveries[:name].matches("%#{params[:term]}%"))

      render json: DeliveryBlueprint.render(@deliveries)
    end
  end
end