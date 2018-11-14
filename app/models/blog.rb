class Blog < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: :slugged

  enum status: { draft: 0, published: 1 }
  
  belongs_to :user

  validates_presence_of :title, :body
end
