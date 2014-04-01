class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :update, :destroy]
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
    new_post = params.require(:post).permit(:city, :name, :category, :description, :price, :image, :contact)
    post = current_user.posts.create(new_post)
    redirect_to root_url
  end

  def show
    @posts = current_user.posts
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    post = Post.find(params[:id])
    post.update_attributes(params[:post].permit(:city, :name, :category, :description, :price, :image, :contact))

    respond_to do |f|
      f.html {redirect_to profile_path(current_user)}
      f.json {render json: post, status: 200}
    end
  end
end
