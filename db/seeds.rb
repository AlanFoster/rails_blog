Post.delete_all
Comment.delete_all
User.delete_all

first_user = User.create email: 'alan@example.com', password: 'password'

first_blog = Post.create title: 'My Post Title', content: 'My Content'
first_blog.comments.create(name: 'Alan', content: 'Comment', website: 'http://example.com')

# Create random posts
1.upto(15) do
  Post.create title: Faker::Lorem.word, content: Faker::Lorem.paragraph, created_at: Date.today - Faker::Number.number(2).to_i.months
end

