FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    expired_at { Time.now }
  end
  factory :second_task, class: Task do
    title { '万葉課題' }
    content { 'STEP3' }
    expired_at { Time.now.since(3.days) }
  end
  factory :third_task, class: Task do
    title { '終了期限でソート' }
    content { 'テスト確認' }
    expired_at { Time.now.since(5.days) }
  end
end