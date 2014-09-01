require 'rails_helper'

describe Admin::PostsController do
  let(:mock_post) { FactoryGirl.build(:post) }

  describe '#index' do
    context 'no posts' do
      before :each do
        get :index
      end

      it { expect(response.status).to eq(200) }
      it { expect(assigns(:posts)).to_not be_nil }
    end
  end

  describe '#new' do
    before :each do
      get :new
    end
    it { expect(response.status).to eq(200) }
  end

  describe '#create' do
    let(:create_request) do
      post :create, post: { title: mock_post.title, content: mock_post.content }
    end

    it { expect { create_request }.to change { Post.count }.from(0).to(1) }
    it { expect(create_request).to redirect_to(assigns(:post)) }
  end

  describe '#edit' do
    let(:mock_post) { FactoryGirl.create(:post) }

    before :each do
      get :edit, id: mock_post
    end

    it { expect(response.status).to eq(200) }
  end

  describe '#update' do
    let(:mock_post) { FactoryGirl.create(:post) }

    let(:update_call) do
      patch :update, id: mock_post, post: { content: mock_post.content, title: mock_post.title }
    end

    it { expect(update_call).to redirect_to(assigns(:post)) }

  end
end
