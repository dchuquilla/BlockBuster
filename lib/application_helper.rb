# frozen_string_literal

module ApplicationHelper
  def generate_password
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
    password = ''
    10.times do
      password << chars.sample.to_s
    end
    password
  end
end
