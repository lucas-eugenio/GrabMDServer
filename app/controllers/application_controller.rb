# frozen_string_literal: true

# Controllers/ApplicationController
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
end
