class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file
      t.string :filename
      t.string :file_type
      t.string :attachable_type
      t.integer :attachable_id
    end
  end
end
