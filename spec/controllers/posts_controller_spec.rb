require_relative '../rails_helper'

describe PostsController do
  let(:mock_post) { FactoryGirl.build(:post) }

  describe '#get' do
    context 'no posts' do
      before :each do
        get :index
      end

      it { expect(response.status).to eq(200) }
      it { expect(assigns(:posts)).to_not be_nil }
    end

    context 'many posts' do
      before :each do
        FactoryGirl.create(:post, title: 'First')
        FactoryGirl.create(:post, title: 'Second')
        FactoryGirl.create(:post, title: 'Third')

        get :index
      end

      it { expect(response.status).to eq(200) }
      it { expect(assigns(:posts)).to_not be_nil }
      it { expect(assigns(:posts).map(&:title)).to match %w(Third Second First) }
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

  describe '#show' do
    let(:mock_post) { FactoryGirl.create(:post) }
    before :each do
      get :show, id: mock_post
    end

    it { expect(response.status).to eq(200) }
    it { expect(assigns(:new_comment)).to_not be_nil}
    it { expect(assigns(:new_comment).post_id).to eq(mock_post.id)}
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

  describe '#destroy' do
    let(:destroy_call) { delete :destroy, id: @post }

    before :each do
      @post = FactoryGirl.create(:post)
    end

    it { expect { destroy_call }.to change { Post.count }.from(1).to(0) }
    it { expect(destroy_call).to redirect_to(posts_path) }
  end

  describe '#overview' do
    let(:get_overview) { get :overview }

    context 'no posts' do
      before :each do
        get_overview
      end
      it { expect(response.status).to eq(200) }
      it { expect(assigns(:overview)).to eq({}) }
    end

    context 'one post' do
      let(:expected_result) do
        {
            'November' => [
                @nov
            ]
        }
      end

      before :each do
        @nov = FactoryGirl.create(:post, created_at: "01/Nov/2013 12:00:00 +0100".to_datetime)

        get_overview
      end

      it { expect(response.status).to eq(200) }
      it { expect(assigns(:overview)).to eq(expected_result) }
    end

    context 'single post a month' do
      let(:expected_result) do
        {
            'November' => [
                @nov
            ],
            'December' => [
                @dec
            ],
            'January' => [
                @jan
            ]
        }
      end

      before :each do
        @nov = FactoryGirl.create(:post, created_at: "01/Nov/2013 12:00:00 +0100".to_datetime)
        @dec = FactoryGirl.create(:post, created_at: "01/Dec/2013 12:00:00 +0100".to_datetime)
        @jan = FactoryGirl.create(:post, created_at: "01/Jan/2013 12:00:00 +0100".to_datetime)

        get_overview
      end

      it { expect(response.status).to eq(200) }
      it { expect(assigns(:overview)).to eq(expected_result) }
    end

    context 'multiple posts in a single month' do
      let(:expected_result) do
        {
            'November' => [
                @nov1,
                @nov2,
                @nov3
            ]
        }
      end
      before :each do
        @nov1 = FactoryGirl.create(:post, created_at: "01/Nov/2013 12:00:00 +0100".to_datetime)
        @nov2 = FactoryGirl.create(:post, created_at: "15/Nov/2013 12:00:00 +0100".to_datetime)
        @nov3 = FactoryGirl.create(:post, created_at: "16/Nov/2013 12:00:00 +0100".to_datetime)

        get_overview
      end

      it { expect(response.status).to eq(200) }
      it { expect(assigns(:overview)).to eq(expected_result) }
    end
  end
end
