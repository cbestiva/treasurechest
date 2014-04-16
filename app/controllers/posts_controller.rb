class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :update, :destroy]
  def index
    if (params[:city] == nil && params[:search] == nil && params[:category_id] == nil) || (params[:city] == "" && params[:search] == "" && params[:category_id] == "")
      @posts = Post.all.order('created_at DESC').paginate(:per_page => 8, :page => params[:page])
    elsif params[:search] == "" && params[:category_id] == ""
      @posts = Post.where(city: params[:city]).paginate(:per_page => 8, :page => params[:page])
    elsif params[:category_id] == ""
      @posts = Post.search(params[:search]).where(city: params[:city]).paginate(:per_page => 8, :page => params[:page])
    else
      @posts = Post.search(params[:search]).where(city: params[:city]).where(category_id: params[:category_id]).paginate(:per_page => 8, :page => params[:page])
    end
  end

  def new
    @post = Post.new
    # @post = Post.new(key: params[:key])
  end

  def create
    new_post = params.require(:post).permit(:city, :name, :category_id, :description, :price, :image, :contact, :key)
    @post = current_user.posts.create(new_post)
    
    respond_to do |f|
      f.html {redirect_to root_url}
      f.json {render json: @post}
    end
  end

  def show
    @posts = current_user.posts
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update_attributes(params[:post].permit(:city, :name, :category_id, :description, :price, :image, :contact, :key))

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
