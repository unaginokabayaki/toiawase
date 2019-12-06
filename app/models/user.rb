# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  image           :string(255)
#  mail            :string(255)
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  profile         :string(255)
#  remember_token  :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#

class User < ApplicationRecord
  has_secure_password
  has_many :issues
  mount_uploader :image, ImageUploader
  
  validates :name, 
    presence: true,
    uniqueness: true,
    length: { maximum: 16 }
    # format: { with: /\A[a-z0-9]+\z/, allow_blank: true, message: 'は小文字英数字で入力してください' }
    
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :mail,
    presence: true,
    uniqueness: true, 
    length: { maximum: 256, allow_blank: true },
    format: { with: VALID_EMAIL_REGEX, allow_blank: true, message: 'が正しいメールアドレスではありません' }

  validates :password,
    length: { minimum: 8, allow_blank: true }
  
  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end
end
