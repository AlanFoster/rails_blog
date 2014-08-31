# Note - Ensure that the correct sanitization is used when taking user input
class Comment < ActiveRecord::Base
  belongs_to :post
end
