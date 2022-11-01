module Api
  class ProductsController < ApplicationController
    def update
      @product = Product.find params[:id]

      @product.update! status_id: params[:product][:status_id]

      head :ok
    end
  end
end