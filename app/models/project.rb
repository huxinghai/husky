class Project < ActiveRecord::Base
  extend ActsAsStatus

  paginates_per 30

  attr_accessor :budget_list

  belongs_to :owner, class_name: :User, foreign_key: :owner_id
  belongs_to :category

  has_many :project_tag_ships
  has_many :project_attachment
  has_many :budgets, class_name: "ProjectBudget"
  has_many :attachments, through: :project_attachment
  has_many :tags, through: :project_tag_ships
  has_many :biddings

  validates :owner, presence: true, allow_blank: false
  validates :category, presence: true, allow_blank: false
  validates :name, presence: true
  validates :budget_state, presence: true

  validate :valid_budget?

  acts_as_status :budget_state, [:total, :time_ranage]

  before_validation(on: :create) do 
    build_budgets
  end

  def is_just_now?
    Time.now < created_at + 5.seconds
  end

  def budget_state_text
    
  end

  private
  def valid_budget?
    if budget_state == :total
      errors.add(:budget, "不能为空!") if budget.blank?
    elsif budget_state == :time_ranage
      errors.add(:budget, "不能为空!") if budget_list.blank? || budgets.length <= 0 
    else
      errors.add(:budget, "选择不正确!")
    end
  end

  def build_budgets
    if budget_state == :time_ranage
      (budget_list || {}).each{|k,v|  budgets.build(kind: k, price: v) }      
    end
  end
end
