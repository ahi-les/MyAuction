require 'debug'
class PricesController < ApplicationController
  # before_action :set_product!
  def new
    @product = Product.find params[:product_id]
    @price = @product.prices.build
    # binding.break
    @product = Product.find params[:product_id] 
  end

  def create
    @product = Product.find params[:product_id]
    success, @price = Prices::CreateService.call @product, price_params

    if success
      flash.now[:success] = 'Price created!'
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def create_index
    @price = Price.new price_params
    if @price.save
      flash[:success] = "Price created!"
      redirect_to products_path
    else
      flash[:success] = "Price not created!"
      render :new, status: :unprocessable_entity
    end
  end

  private

  # def set_product!
  #   @product = Product.find params[:product_id]
  # end

  def price_params
    params.require(:price).permit( :price, :product_id)
  end

  
end