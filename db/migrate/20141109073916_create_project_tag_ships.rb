class CreateProjectTagShips < ActiveRecord::Migration
  def change
    create_table :project_tag_ships do |t|
      t.integer :project_id
      t.integer :tag_id
    end
  end
end
