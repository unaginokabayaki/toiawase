class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.references :product, foreign_key: true
      t.string :product_feature
      t.references :issue_type, foreign_key: true
      t.string :content
      t.string :solution
      t.references :responder, foreign_key: { to_table: :users }
      t.string :reporter_name
      t.string :site_name

      t.timestamps
    end
  end
end
