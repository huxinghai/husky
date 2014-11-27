class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :from_user_id
      t.text    :description
      t.integer :to_user_id
      t.string  :email
      t.integer :team_id

      t.timestamps
    end
  end
end
