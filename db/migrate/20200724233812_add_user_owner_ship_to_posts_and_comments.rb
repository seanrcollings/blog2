class AddUserOwnerShipToPostsAndComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :user, null: false, foreign_key: true, default: 1
    add_reference :comments, :user, null: false, foreign_key: true, default: 1
  end
end
