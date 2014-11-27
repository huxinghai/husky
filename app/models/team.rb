class Team < ActiveRecord::Base
  has_many :user_team_ships
  has_many :users, through: :user_team_ships
  belongs_to :owner, class_name: :User, foreign_key: :owner_id
  has_many :biddings
  has_many :invitations

end
