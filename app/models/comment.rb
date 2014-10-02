# Note - Ensure that the correct sanitization is used when taking user input
class Comment < ActiveRecord::Base
  belongs_to :post

  validates :name, presence: true, length: { in: 3..30 }
  validates :content, presence: true, length: { in: 3..5000 }
  validates :website, presence: true, length: { in: 3..30 }
end
