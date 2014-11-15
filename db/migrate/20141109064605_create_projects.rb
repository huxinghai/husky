class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :category_id
      t.integer :owner_id
      t.integer :attachment_id

      t.string :name
      t.float :budget
      t.text :description

      t.datetime :dead_line
      t.datetime :bidding_dead_line
      t.integer :status
      t.timestamps
    end
  end
end
