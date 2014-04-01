class PostsController < ApplicationController
  def index
    @posts = Post.all

    respond_to do |f|
      f.html
      f.json {render json: @posts}
    end
  end

  def new
    @post = Post.new
  end

  def create
    new_post = params.require(:post).permit(:city, :name, :category, :description, :price, :image)
    post = Post.create(new_post)
    redirect_to root_url
  end

  def show
    @posts = current_user.posts
  end
end
