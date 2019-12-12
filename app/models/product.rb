# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  description :text(65535)
#  name        :string(255)
#  sort        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
  has_many :issues
end
