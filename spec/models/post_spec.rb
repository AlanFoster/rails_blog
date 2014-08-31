require_relative '../rails_helper'

describe Post do
  describe 'title' do
    it { expect((Post.new title: 'My post title').title).to eql 'My post title'}
  end

  describe 'content' do
    it { expect((Post.new content: 'My post content').content).to eql 'My post content'}
  end

  describe 'created_at' do
    let(:creation_time) { DateTime.now }
    it { expect((Post.new created_at: creation_time).created_at).to eql creation_time}
  end
end
