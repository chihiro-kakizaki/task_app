# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  name:  '管理者',
  email: 'admin@gmail.com',
  password:  '1111',
  admin: true
  )

9.times do |i|
  User.create!(
    name: "テストユーザー#{i + 1}",
    email: "test#{i + 1}@test.com",
    password: "testhoge",
    admin: false
  )
end

10.times do |i|
  Task.create!(
    title: "テストタスク#{i + 1}",
    content: "タスク内容#{i + 1}",
    status: 2,
    priority: 2,
    user_id: 2
  )
end

10.times do |i|
  Label.create!(name: "ラベル#{i + 1}")
end