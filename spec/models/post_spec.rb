require_relative '../rails_helper'

describe Post do

  context 'setting values' do
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

  context 'validation' do
    let(:post_model) { subject }

    it { expect(post_model).to validate_presence_of(:title) }
    it { expect(post_model).to validate_presence_of(:content) }

    it { expect(post_model).to ensure_length_of(:title).is_at_least(3).is_at_most(40) }
    it { expect(post_model).to ensure_length_of(:content).is_at_least(3).is_at_most(30000) }

    it { expect(post_model).to have_many(:comments) }
  end
end
