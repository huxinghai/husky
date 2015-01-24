class ProjectBudget < ActiveRecord::Base
  extend ActsAsStatus

  belongs_to :project
  validates :project, presence: true

  acts_as_status :kind, [:h, :d, :w, :m, :u]


  def kind_at
    I18n.t("activerecord.attributes.project_budget.kind.#{kind.name}")
  end
end
