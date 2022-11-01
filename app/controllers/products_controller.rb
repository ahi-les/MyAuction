class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_product, only: %i[show destroy edit update]
  before_action :fetch_deliveries, only: %i[new edit]
  before_action :fetch_payments, only: %i[new edit]

  def show
    @prices = @product.prices.order created_at: :desc
    # respond_to do |format|
  #     format.html
  #     format.json { render :json => @dish.to_json(:include => [:measure,:pricing_type])}
    # end
  end

  def destroy
    @product.destroy
    flash[:success] = "Product deleted!"
    redirect_to products_path, status: 303
  end

  def edit
  end

  def update
    if @product.update product_params
      flash[:success] = "Product updated!"
      redirect_to products_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    
    @pagy, @products = pagy(Product.all.order('category_id'))
    # @search = SearchParams.new(params[:search_params] || {})
    # @products = @search.product_apply_filters(@products)
    # @pagy, @products = pagy @products
    

  end

  def new
    @product = Product.new
    # @categories = Category.all.arrange(:order => :name).map{ |c| [c.name, "#{c.id}"] }
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = "Product created!"
      redirect_to products_path
    else
      flash[:success] = "Product not created!"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :message,
     :start_date, :end_date, :sity, :starting_price, :buy_now, :category_id,
      :gender_id, :condition_id, :user_id, :status_id, :body, images:[],
       delivery_ids:[], payment_ids:[], prices_attributes:
     Price.attribute_names.map(&:to_sym).push(:_destroy))
  end

  def set_product
    @product = Product.find params[:id]
  end

  def fetch_deliveries
    @deliveries = Delivery.all
  end

  def fetch_payments
    @payments = Payment.all
  end

end