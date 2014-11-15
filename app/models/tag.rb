class Tag < ActiveRecord::Base
  KINDS = ['Skill', 'Language']

  has_many :project_tag_ships
  has_many :projects, through: :project_tag_ships

end
