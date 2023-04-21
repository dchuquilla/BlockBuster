# frozen_string_literal: true

# root app controller to create early executable methods.
class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include QueryHelper::QueryHelperConcern

  respond_to :json
  before_action :create_query_helper

  protected

  def validate_admin_usaer
    render json: 'Please login again', status: :unauthorized and return unless current_user.present?
    return if current_user.is_admin

    render json: 'Only admins allowed', status: :unauthorized and return
  end
end
