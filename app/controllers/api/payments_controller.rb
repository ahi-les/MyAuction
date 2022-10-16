module Api
  class PaymentsController < ApplicationController
    def index
      payments = Payment.arel_table
      @payments = Payment.where(payments[:name].matches("%#{params[:term]}%"))

      render json: PaymentBlueprint.render(@payments)
    end
  end
end