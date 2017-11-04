class AddAvatarToUser < ActiveRecord::Migration[5.1]
  def down
    remove_attachment :users, :avatar
  end
end
