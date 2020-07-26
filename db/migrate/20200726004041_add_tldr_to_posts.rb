class AddTldrToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :tldr, :string, :null => true
  end
end
