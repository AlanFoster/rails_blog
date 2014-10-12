require_relative '../rails_helper'

describe CommentsController do
  describe '#create' do
    let(:target_post) { FactoryGirl.create(:post) }

    let(:request_json) do
      {
          comment: comment_json,
          post_id: target_post.id
      }
    end

    let(:create_request) do
      post :create, request_json
    end

    context 'model valid' do
      let(:comment_json) do
        {
          'name' => Faker::Name.name,
          'website' => Faker::Internet.url,
          'content' => Faker::Lorem.paragraph
        }
      end

      describe 'comment count' do
        it { expect { create_request }.to change { Comment.count }.from(0).to(1) }
      end

      describe 'assignment' do
        before :each do
          create_request
        end

        it { expect(assigns(:comment)).to be_a(Comment) }
        it { expect(assigns(:post)).to be_a(Post) }
        it { expect(create_request).to redirect_to(target_post) }
      end
    end

    context 'invalid additional params' do
      let(:comment_json) do
        {
          'name' => Faker::Name.name,
          'website' => Faker::Internet.url,
          'content' => Faker::Lorem.paragraph,
          'additional_values' => 'invalid'
        }
      end
      let(:expected_initializers) do
        {
            'name' => comment_json['name'],
            'website' => comment_json['website'],
            'content' => comment_json['content']
        }
      end

      before :each do
        allow(Comment).to receive(:new).and_call_original
        create_request
      end

      it { expect(Comment).to have_received(:new).with(expected_initializers) }
    end

    context 'invalid model' do
      let(:comment_json) do
        {
          'name' => 'invalid'
        }
      end
      let(:comment_mock) { double 'comment_mock', save: false }

      before :each do
        allow_any_instance_of(Comment).to receive(:save).and_return(false)
        create_request
      end

      it { expect(create_request).to render_template('posts/show') }
    end
  end
end
