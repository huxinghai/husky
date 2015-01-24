class AddBudgetStateToProject < ActiveRecord::Migration
  def change
    add_column :projects, :budget_state, :integer
  end
end
