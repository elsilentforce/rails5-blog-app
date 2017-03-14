class Article < ApplicationRecord
  validates_presence_of [:title, :body]

  default_scope { order(created_at: :desc) }

  belongs_to :user
  has_many :comments, dependent: :destroy
end
