require 'rails_helper'

describe SessionsController do

  describe "#new" do
    before :each do
      get :new
    end
    it { expect(response.status).to eq(200) }
  end

  describe '#create' do
    let(:create_request) { post :create, json }
    let(:fake_user) { FactoryGirl.create(:user) }

    context 'valid_login' do
      let(:json) do
        {
            email: 'alan@example.com',
            password: 'mocked'
        }
      end

      before :each do
        allow(User).to receive(:authenticate).and_return fake_user
        create_request
      end

      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to(admin_posts_path) }
      it { expect(session[:id]).to eq(fake_user.id) }

      it { expect(User).to have_received(:authenticate).with(json[:email], json[:password]) }
    end

    context 'invalid_login' do
      let(:json) do
        {
            email: 'alan@example.com',
            password: 'mocked'
        }
      end

      before :each do
        allow(User).to receive(:authenticate).and_return nil
        create_request
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to_not redirect_to(admin_posts_path) }
      it { expect(session[:id]).to be_nil }

      it { expect(User).to have_received(:authenticate).with(json[:email], json[:password]) }
    end

    context 'strong_params' do
      let(:json) do
        {
            email: 'alan@example.com',
            password: 'mocked',
            malicious: 'foo'
        }
      end

      before :each do
        allow(User).to receive(:authenticate).and_return nil
        create_request
      end

      it { expect(User).to have_received(:authenticate).with(json[:email], json[:password]) }
    end
  end

  describe '#detroy' do
    before :each do
      delete :destroy
    end

    it { expect(session[:id]).to be_nil }
    it { expect(response).to redirect_to(login_path) }
  end
end
