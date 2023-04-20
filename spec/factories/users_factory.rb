FactoryBot.define do
  factory(:user) do
    name { 'tester' }
    email { 'user@mail.com' }
    password { 'test1234.' }
  end
end
