class Project < ActiveRecord::Base
  extend ActsAsStatus

  paginates_per 30

  attr_accessor :budget_list, :parent_id

  belongs_to :owner, class_name: :User, foreign_key: :owner_id
  belongs_to :category

  has_many :project_tag_ships
  has_many :project_attachment
  has_many :attachments, through: :project_attachment
  has_many :tags, through: :project_tag_ships
  has_many :biddings

  validates :owner, presence: true, allow_blank: false
  validates :category, presence: true, allow_blank: false
  validates :name, presence: true
  validates :budget_state, presence: true
  validates :budget, numericality: {greater_than: 0}

  validate :valid_budget?

  acts_as_status :budget_state, [:h, :d, :w, :m, :u]

  before_validation(on: :create) do 
  end

  def is_just_now?
    Time.now < created_at + 5.seconds
  end

  def budget_state_at
    I18n.t("activerecord.attributes.project.budget_state.#{budget_state.name}")
  end

  private
  def valid_budget?
    unless Project.budget_state_all.include?(budget_state.name)
      errors.add(:budget, "类型选择不正确!")
    end
    errors.add(:budget, "不能为空!") if budget.blank?
  end
end
