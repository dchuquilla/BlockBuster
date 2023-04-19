FactoryBot.define do
  factory(:user) do
    email { 'user@mail.com' }
    password { 'test1234.' }
  end
end
