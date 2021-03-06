class UsersController < ApplicationController
  
  def show
    @user = current_user

    @posts = current_user.posts.order('created_at DESC').paginate(:per_page => 6, :page => params[:page])
    # @uploader = Post.new.image
    # @uploader.success_action_redirect = new_post_url

    respond_to do |f|
      f.html
      f.json {render json: @user.as_json(include: :posts)}
    end
  end

end
