class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    new_category = params.require(:category).permit(:name)
    category = Category.create(new_category)
    redirect_to root_url
  end
end
