class AddColumnMailToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :mail, :string
  end
end
