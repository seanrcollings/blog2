class AddDefaultColorToTags < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tags, :color, from: nil, to: "#3cb371"
  end
end
