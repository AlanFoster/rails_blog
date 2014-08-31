require 'rails_helper'

describe Comment do
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
