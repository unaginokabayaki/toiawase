# == Schema Information
#
# Table name: issue_comment_likes
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  issue_comment_id :integer
#  user_id          :integer
#
# Indexes
#
#  index_issue_comment_likes_on_issue_comment_id  (issue_comment_id)
#  index_issue_comment_likes_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (issue_comment_id => issue_comments.id)
#  fk_rails_...  (user_id => users.id)
#

class IssueCommentLike < ApplicationRecord
  belongs_to :user
  belongs_to :issue_comment
end
