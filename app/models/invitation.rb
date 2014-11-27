class Invitation < ActiveRecord::Base
  belongs_to :team
  after_create :add_user_to_team

  validates_presence_of :email, message: "email 不能为空。"

  def add_user_to_team
    unless to_user_id.nil?
      user_team_ship = UserTeamShip.new(user_id: to_user_id, team_id: team_id)
      if user_team_ship.save
        true
      else
        errors.add(:to_user_id, user_team_ship.errors.messages[:user_id])
      end
    end
  end
end
