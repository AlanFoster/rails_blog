# Note - Ensure that the correct sanitization is used when taking user input
class Comment < ActiveRecord::Base
  belongs_to :post

  validates :name, presence: true, length: { in: 0..30 }
  validates :content, presence: true, length: { in: 3..5000 }
  validates :website, length: { in: 0..50 }
end
