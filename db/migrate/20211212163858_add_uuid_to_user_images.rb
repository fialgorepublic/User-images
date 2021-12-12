class AddUuidToUserImages < ActiveRecord::Migration[5.2]
  def change
    add_column :user_images, :uuid, :string
  end
end
