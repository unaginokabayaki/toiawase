class CreateIssueCommentLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :issue_comment_likes do |t|
      t.references :user, foreign_key: true
      t.references :issue_comment, foreign_key: true

      t.timestamps
    end
  end
end
