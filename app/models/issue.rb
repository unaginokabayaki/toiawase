# == Schema Information
#
# Table name: issues
#
#  id              :integer          not null, primary key
#  content         :string(255)
#  product_feature :string(255)
#  reporter_name   :string(255)
#  site_name       :string(255)
#  solution        :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  issue_type_id   :integer
#  product_id      :integer
#  responder_id    :integer
#
# Indexes
#
#  index_issues_on_issue_type_id  (issue_type_id)
#  index_issues_on_product_id     (product_id)
#  index_issues_on_responder_id   (responder_id)
#
# Foreign Keys
#
#  fk_rails_...  (issue_type_id => issue_types.id)
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (responder_id => users.id)
#

class Issue < ApplicationRecord
  belongs_to :product
  belongs_to :issue_type
  belongs_to :responder, class_name: 'User'
  has_many :issue_comments, dependent: :delete_all
end
