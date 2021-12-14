class AddStatusToUserImages < ActiveRecord::Migration[5.2]
  def change
    add_column :user_images, :status, :boolean, default: false
  end
end
