class DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
  end
  def users
    respond_to do |format|
      format.html
    end
  end
  def orders
    respond_to do |format|
      format.html
    end
  end
end
