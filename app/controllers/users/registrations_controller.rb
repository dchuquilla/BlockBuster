# frozen_string_literal: true

module Users
  # Customize devise registrations controller to controll the users registrations flow
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]

    def create
      super
    end

    private

    def respond_with(resource, _opts = {})
      Rails.logger.info 'resource.errors'
      Rails.logger.info resource.errors.inspect
      resource.persisted? ? register_success : register_failed
    end

    def register_success
      render json: { message: 'Successfuly signed up.' }, status: :ok
    end

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    end

    def register_failed
      render json: { message: 'Sign up failure.' }, status: :unprocessable_entity
    end
  end
end
