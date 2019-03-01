class ApplicationController < ActionController::Base
  include ResponseManager
  skip_before_action :verify_authenticity_token
end
