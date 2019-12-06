# == Schema Information
#
# Table name: issue_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  sort       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class IssueTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
