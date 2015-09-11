require 'file_size_validator'
class Converter < ActiveRecord::Base
  mount_uploader :file, FileUploader

  validates :file,
            :presence => true,
            :file_size => {
                :maximum => 1.megabytes.to_i
            }
end
