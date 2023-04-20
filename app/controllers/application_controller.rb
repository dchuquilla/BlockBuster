# frozen_string_literal: true

# root app controller to create early executable methods.
class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include QueryHelper::QueryHelperConcern

  respond_to :json
  before_action :create_query_helper
end
