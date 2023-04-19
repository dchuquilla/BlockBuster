# frozen_string_literal: true

# root app controller to create early executable methods.
class ApplicationController < ActionController::API
  respond_to :json
  include ActionCOntroller::MimeResponds
end
