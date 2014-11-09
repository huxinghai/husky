class Bidding < ActiveRecord::Base
  belongs_to :project
  belongs_to :team
  belongs_to :user

end
