class AddColumnToIssueType < ActiveRecord::Migration[5.0]
  def change
    add_column :issue_types, :sort, :integer
  end
end
