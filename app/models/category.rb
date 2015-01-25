class Category < ActiveRecord::Base
  has_many :projects

  belongs_to  :parent, foreign_key: :parent_id , class_name: :Category
  has_many    :childrens, foreign_key: :parent_id , class_name: :Category , dependent: :destroy

  class << self
    def root
      where(:parent_id => nil)
    end

  end
end
