class City < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :province, presence: true

  belongs_to :province
end
