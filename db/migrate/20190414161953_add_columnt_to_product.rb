class AddColumntToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :sort, :integer
  end
end
