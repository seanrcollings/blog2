class ChangeTagColorDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tags, :color, nil
  end
end
