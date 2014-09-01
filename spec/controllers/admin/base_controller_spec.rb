RSpec.describe Admin::BaseController do

  # Test the anonymous custom controller
  controller(Admin::BaseController) do
    def index
      render text: 'hello world'
    end
  end

  describe '#filter_admin' do
    context 'validated' do
      before :each do
        session[:id] = 1337
        get :index
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to match 'hello world' }
    end

    context 'not validated' do
      before :each do
        get :index
      end

      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to(sessions_path) }
    end
  end
end
