class CreateProjectBudgets < ActiveRecord::Migration
  def change
    create_table :project_budgets do |t|
      t.integer :project_id
      t.integer :kind
      t.float :price

      t.timestamps
    end
  end
end
