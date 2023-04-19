# frozen_string_literal: true

module Users
  # Customize devise registrations controller to controll the users registrations flow
  class RegistrationsController < Devise::RegistrationsController
    private

    def respond_with(resource, _opts = {})
      resource.persisted? ? register_success : register_failed
    end

    def register_success
      render json: { message: 'Successfuly signed up.' }
    end

    def register_failed
      render json: { message: 'Sign up failure.' }
    end
  end
end
