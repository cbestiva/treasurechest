class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  mount_uploader :image, ImageUploader

  after_save :enqueue_image

  def image_name
    File.basename(image.path || image.filename) if image
  end

  def enqueue_image
    ImageWorker.perform_async(id, key) if !image_processed && key.present?
  end

  class ImageWorker
    include Sidekiq::Worker
    def perform(id, key)
        post = Post.find(id)
        post.key = key
        post.remote_image_url = post.image.direct_fog_url(:with_path => true)
        post.save!
        post.update_column(:image_processed, true)
    end
  end
end
