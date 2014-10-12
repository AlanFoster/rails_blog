require_relative '../rails_helper'

describe ApplicationController do
  describe '#current_user' do
    context 'when session not set' do
      before :each do
        @current_user = FactoryGirl.create(:user)
      end

      it { expect(subject.current_user).to be_nil }
    end

    context 'when user exists and valid' do
      before :each do
        @current_user = FactoryGirl.create(:user)
        session[:id] = @current_user.id
      end

      it { expect(subject.current_user).to eq(@current_user) }
    end

    context 'when  session set and user does not exist' do
      before :each do
        session[:id] = 1337
      end

      it { expect(subject.current_user).to be_nil }
      it 'clears the invalid session id' do
        subject.current_user
        expect(session[:id]).to be_nil
      end
    end
  end
end