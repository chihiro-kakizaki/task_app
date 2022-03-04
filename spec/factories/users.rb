FactoryBot.define do
  factory :user do
    name { '管理者' }
    email { 'admin@gmail.com' }
    password { '1111' }
    admin { 'true' }
  end
  factory :second_user, class: User do
    name { '一般' }
    email { 'general@gmail.com' }
    password { '1111' }
    admin { 'false' }  
  end
end
