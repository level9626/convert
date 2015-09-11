class Converter < ActiveRecord::Base
  mount_uploader :file, FileUploader
end
