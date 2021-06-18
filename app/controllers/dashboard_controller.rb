class DashboardController < ApplicationController
  before_action :authenticate_host!
  layout 'dashboard'
end