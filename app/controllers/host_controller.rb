class HostController < ApplicationController
  before_action :authenticate_host!
  layout 'host'
end