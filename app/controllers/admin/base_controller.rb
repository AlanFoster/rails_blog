module Admin
  class BaseController < ApplicationController
    before_filter :filter_admin

    def filter_admin
      unless logged_in?
        redirect_to sessions_path
      end
    end
  end
end
