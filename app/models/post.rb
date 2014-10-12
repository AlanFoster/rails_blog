class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { in: 3..50 }
  validates :content, presence: true, length: { in: 3..30000 }

  def self.overview
    all.group_by { |post| post.created_at.month }
       .transform_keys { |ordinal_month| Date::MONTHNAMES[ordinal_month]  }
  end
end
