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

require 'rails_helper'

RSpec.describe IssueComment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
