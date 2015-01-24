class ProjectAttachment < ActiveRecord::Base
  belongs_to :project
  belongs_to :attachment

  validates :project, presence: true
  validates :attachment, presence: true
  
end
