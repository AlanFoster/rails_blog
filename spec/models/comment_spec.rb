require 'rails_helper'

describe Comment do
  context 'setting values' do
    describe 'name' do
      it { expect((Comment.new name: 'Alan').name).to eql 'Alan'}
    end

    describe 'content' do
      it { expect((Comment.new content: 'Comment Content').content).to eql 'Comment Content'}
    end

    describe 'website' do
      it { expect((Comment.new website: 'http://example.com').website).to eql 'http://example.com'}
    end

    describe 'created_at' do
      let(:creation_time) { DateTime.now }
      it { expect((Comment.new created_at: creation_time).created_at).to eql creation_time}
    end
  end

  context 'validation' do
    let(:comment_model) { subject }

    it { expect(comment_model).to validate_presence_of(:name) }
    it { expect(comment_model).to validate_presence_of(:content) }
    it { expect(comment_model).to_not validate_presence_of(:website) }

    it { expect(comment_model).to ensure_length_of(:name).is_at_most(30) }
    it { expect(comment_model).to ensure_length_of(:content).is_at_least(3).is_at_most(5000) }
    it { expect(comment_model).to ensure_length_of(:website).is_at_most(50) }

    it { expect(comment_model).to belong_to(:post) }
  end
end
