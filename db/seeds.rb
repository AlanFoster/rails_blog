require 'active_model'
require_relative 'legacy_data'

def delete_all
  models = %i(
    Post
    Comment
    User
  )

  models.each do |model|
    Object.const_get(model).delete_all
  end
end

def seed_users
  User.create email: 'alan@example.com', password: 'password'
end

def seed_posts
  field_mappings = {
    id: :id,
    title: :title,
    content: :content,
    created_at: :date
  }

  LegacyData::seed :Post, field_mappings
end

def seed_comments
  field_mappings = {
    id: :postid,
    post_id: :id,
    name: :name,
    website: :website,
    content: :comment,
    created_at: :date
  }

  LegacyData::seed :Comment, field_mappings
end

# Begin Seeding
delete_all
seed_users
seed_posts
seed_comments

