Post.delete_all
Comment.delete_all

first_blog = Post.create title: 'My Post Title', content: 'My Content'
first_blog.comments.create(name: 'Alan', content: 'Comment', website: 'http://example.com')

# Create random posts
1.upto(15) do
  Post.create title: Faker::Lorem.word, content: Faker::Lorem.paragraph
end
