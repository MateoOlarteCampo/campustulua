class Archive < ApplicationRecord
  belongs_to :course

  default_scope { order('created_at DESC') } 
  
  mount_uploader :file, FileUploader

end
