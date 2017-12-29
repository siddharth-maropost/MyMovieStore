class AddColumnViewCountToMovie < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :view, :integer, :default => 0
  end
end
