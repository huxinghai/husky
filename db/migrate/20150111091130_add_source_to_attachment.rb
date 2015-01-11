class AddSourceToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :source, :integer
  end
end
