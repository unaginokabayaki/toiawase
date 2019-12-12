# == Schema Information
#
# Table name: issue_comments
#
#  id         :integer          not null, primary key
#  comment    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  issue_id   :integer
#  user_id    :integer
#
# Indexes
#
#  index_issue_comments_on_issue_id  (issue_id)
#  index_issue_comments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (issue_id => issues.id)
#  fk_rails_...  (user_id => users.id)
#

class IssueComment < ApplicationRecord
  belongs_to :issue
  belongs_to :user
  has_many :issue_comment_likes, dependent: :delete_all
  
  validates :comment, presence: true, length: { maximum: 256, allow_blank: true }

  def likes_count
    IssueCommentLike.where(issue_comment_id: self.id).count
  end

  def liked?(user_id)
    IssueCommentLike.where(issue_comment_id: self.id).exists?(user_id: user_id)
  end
end
