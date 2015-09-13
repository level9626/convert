require 'file_size_validator'
require 'json'
require 'csv'
require 'fileutils'
require 'nokogiri'

class Converter < ActiveRecord::Base
  mount_uploader :file, FileUploader
  EXTENSION = [ 'csv' ]

  ## Validations
  validates :file,
            presence: true,
            file_size: {
                :maximum => 1.megabytes.to_i
            }

  validates :extension, presence: true

  ## Callbacks
  after_save :change_file


  ## Convert files after file save
  def change_file

    ## If uploading file extension equal JSON and convert to CSV
    if (file.file.extension == 'json' && extension == 'csv')
      open_file = File.open("#{Rails.root}/public/uploads/converter/file/#{id}/#{file.filename}")

      csv_string = CSV.generate do |csv|
        JSON.parse(open_file.read).each do |hash|
          csv << hash
        end
      end

      File.open(open_file, 'w') do |hash|
        hash << csv_string
      end

      Dir.glob("/#{Rails.root}/public/uploads/converter/file/#{id}/*.json").each do |f|
        FileUtils.mv f, "#{File.dirname(f)}/data.csv"
      end

    ## If uploading file extension equal XML and convert to CSV
    elsif (file.file.extension == 'xml' && extension == 'csv')
      open_file = File.open("#{Rails.root}/public/uploads/converter/file/#{id}/#{file.filename}")
      read_file = File.read("#{Rails.root}/public/uploads/converter/file/#{id}/#{file.filename}")
      doc = Nokogiri::XML(read_file)
      csv_string = CSV.generate do |csv|
        doc.search('book').each do |x|
          csv << x.search('*').map(&:text)
        end
      end

      File.open(open_file, 'w') do |hash|
        hash << csv_string
      end

      Dir.glob("/#{Rails.root}/public/uploads/converter/file/#{id}/*.xml").each do |f|
        FileUtils.mv f, "#{File.dirname(f)}/data.csv"
      end

    end
  end
end
