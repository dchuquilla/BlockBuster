# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ['react.block-buster.com']

    resource '*', headers: :any, expose: %w[Authorization],
                  methods: %i[get post put patch delete options head]
  end
end
