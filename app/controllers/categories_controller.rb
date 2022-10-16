class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_category, only: %i[show destroy edit update]
  def show

  end

  def destroy
    @category.destroy
    flash[:success] = "Category deleted!"
    redirect_to categories_path, status: 303
  end

  def edit
    @categories = Category.all.where("id != #{@category.id}").map{ |c| [c.name, "#{c.id}"] }
  end

  def update
    if @category.update category_params
      flash[:success] = "Category updated!"
      redirect_to categories_path
    else
       @categories = Category.all.where("id != #{@category.id}").map{ |c| [c.name, "#{c.id}"] }
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @pagy, @categories = pagy(Category.all)
  end

  def new
    @category = Category.new
    @categories = Category.all.map{ |c| [c.name, "#{c.id}"] }
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "Category created!"
      redirect_to categories_path
    else
    @categories = Category.all.map{ |c| [c.name, "#{c.id}"] }

      render :new, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end

  def set_category
    @category = Category.find params[:id]
  end
end