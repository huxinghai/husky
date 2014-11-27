
class UserTeamShip < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  validates_uniqueness_of :user_id, scope: [:user_id, :team_id], message: "用户已经在这个团队中了。"
end
