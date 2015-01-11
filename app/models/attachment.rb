require 'file_size_validator' 

class Attachment < ActiveRecord::Base
  extend ActsAsStatus

  mount_uploader :file, FileUploader

  acts_as_status :source, [:project]

  validates :file, :presence => true, 
    :file_size => { 
      :maximum => 60.megabytes.to_i
    } 

  before_save :change_file_info

  def change_file_info
    self.filename = file.filename
    self.file_type = File.extname(file.file.file)[1..-1]
  end

  class << self

    def new_project
      new(source: :project)
    end
  end
end