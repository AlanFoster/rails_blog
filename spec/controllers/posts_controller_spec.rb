require_relative '../rails_helper'

describe PostsController do
  let(:mock_post) { FactoryGirl.build(:post) }

  describe '#index' do
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

  describe '#show' do
    let(:mock_post) { FactoryGirl.create(:post) }
    before :each do
      get :show, id: mock_post
    end

    it { expect(response.status).to eq(200) }
    it { expect(assigns(:comment)).to_not be_nil}
    it { expect(assigns(:comment).post_id).to eq(mock_post.id)}
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
