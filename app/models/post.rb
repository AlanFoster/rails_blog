class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { in: 3..50 }
  validates :content, presence: true, length: { in: 3..30000 }
end
