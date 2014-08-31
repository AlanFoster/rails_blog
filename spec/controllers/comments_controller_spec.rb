describe CommentsController do
  describe '#create' do
    let(:comment_json) do
      {
          'name' => Faker::Name.name,
          'website' => Faker::Internet.url,
          'content' => Faker::Lorem.paragraph,
          'post_id' => target_post.id
      }
    end

    let(:create_request) do
      post :create, comment: comment_json
    end

    context 'valid post_id supplied' do
      let(:target_post) { FactoryGirl.create(:post) }
      it { expect { create_request }.to change { Comment.count }.from(0).to(1) }
      it { expect(create_request).to redirect_to(target_post) }

      context 'strong_params' do
        let(:expected_initializers) do
          hash_including({
            'name' => comment_json['name'],
            'website' => comment_json['website'],
            'content' => comment_json['content'],
            # TODO Doesn't work as expected
            # 'post_id' => comment_json['post_id']
          })
        end

        before :each do
          allow(Comment).to receive(:new).and_call_original
          create_request
        end

        it { expect(Comment).to have_received(:new).with(expected_initializers) }
      end
    end

    context 'invalid data supplied' do
      pending 'add tests for invalid data, post_id etc'
    end
  end
end
