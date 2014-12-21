class Category < ActiveRecord::Base
  has_many :projects

  class << self
    def root
      where(:parent_id => nil)
    end

  end
end
