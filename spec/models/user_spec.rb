require 'rails_helper'

describe User do
  describe '#encrypt_password' do
    let(:user) { User.new email: 'alan@example.com', password: 'password' }

    it { expect(user.password).to eq 'password' }
    it { expect(user.tap(&:save).password).to be_nil }
    it { expect(user.tap(&:save).password_salt).to_not be_nil }
    it { expect(user.tap(&:save).password_hash).to_not be_nil }
  end

  describe '#authenticate' do
    let(:valid_email) { 'alan@example.com' }
    let(:invalid_email) { 'john@example.com' }

    let(:valid_password) { 'password' }
    let(:invalid_password) { 'wrong_password' }

    context 'no params' do
      it { expect(User.authenticate(nil, nil)).to be_nil }
    end

    context 'valid email, valid password' do
      before :each do
        @user = FactoryGirl.create(:user)
      end

      it { expect(User.authenticate(valid_email, valid_password)).to eq @user }
    end

    context 'invalid email, invalid password' do
      before :each do
        @user = FactoryGirl.create(:user)
      end

      it { expect(User.authenticate(invalid_email, invalid_password)).to be_nil }
    end

    context 'valid email, invalid password' do
      before :each do
        @user = FactoryGirl.create(:user)
      end

      it { expect(User.authenticate(valid_email, invalid_password)).to be_nil }
    end

  end
end
