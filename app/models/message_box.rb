class MessageBox
  include ActiveModel::Model

  attr_accessor :title, :message, :commit, :cancel

end