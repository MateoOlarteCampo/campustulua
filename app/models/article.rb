class Article < ApplicationRecord
	
	default_scope { order('created_at DESC') } 

	validates :title, presence: true,  length: { maximum: 30}
	validates :body, presence: true
	
	belongs_to :user
	has_many :comments


	attr_accessor :image_width, :image_height
	mount_uploader :picture, ArticlePictureUploader
	validate :check_dimensions, :on => [:create, :update]


	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
	end

	def check_dimensions
	    if !picture_cache.nil? && (picture.width < 1400 || picture.height < 500)
	      errors.add :image, "Dimension too small. Minimum 1400pxx500px"
	    end
  	end

	
end
