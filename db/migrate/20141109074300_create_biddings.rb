class CreateBiddings < ActiveRecord::Migration
  def change
    create_table :biddings do |t|
      t.integer :project_id
      t.integer :team_id
      t.integer :user_id
      t.integer :attachment_id

      t.float :price
      t.text :description
      t.integer :attachment_id

      t.timestamps
    end
  end
end
