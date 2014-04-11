class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :update, :destroy]
  def index
    if params[:search] == nil
      @posts = Post.all
    else
      @posts = Post.where(city: params[:search]) 
    end
  end

  def city

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

  def destroy
    post = Post.find(params[:id])
    post.delete

    respond_to do |f|
      f.html {redirect_to profile_path(current_user)}
      f.json {render json: post, status: 200}
    end
  end

end
