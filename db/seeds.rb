require 'active_model'

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

  seed_old_model :Post, field_mappings
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

  seed_old_model :Comment, field_mappings
end

def seed_old_model(model_name, field_mappings)
  seed_data = load_seed_data("#{model_name.downcase}s")
  seed_data.map(&:with_indifferent_access).each do |model_data|
    model_attributes = create_model_attributes(field_mappings, model_data)
    Object.const_get(model_name).create model_attributes
  end
end

def create_model_attributes(field_mappings, model)
  field_mappings.inject({}) do |mapping, (new_field, old_field)|
    mapping[new_field] = model[old_field]
    mapping
  end
end

def load_seed_data(name)
  path = File.join Rails.root,
                   'db',
                   'seed_data',
                   "old_#{name}.yml"

  YAML::load_file(path)
end

# Begin Seeding
delete_all
seed_users
seed_posts
seed_comments

