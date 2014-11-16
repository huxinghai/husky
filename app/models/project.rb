class Project < ActiveRecord::Base
  belongs_to :owner, class_name: :User, foreign_key: :owner_id
  belongs_to :category

  has_many :project_tag_ships
  has_many :tags, through: :project_tag_ships
  has_many :biddings

  validates :owner, presence: true, allow_blank: false
  validates :category, presence: true, allow_blank: false

end
