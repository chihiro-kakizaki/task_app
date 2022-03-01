FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    expired_at { Time.now }
    status { '未着手' }
    priority { '高'}
  end
  factory :second_task, class: Task do
    title { '万葉課題' }
    content { 'STEP3' }
    expired_at { Time.now.since(3.days) }
    status { '着手中' }
    priority { '中' }
  end
  factory :third_task, class: Task do
    title { '終了期限でソート' }
    content { 'テスト確認' }
    expired_at { Time.now.since(5.days) }
    status { '完了' }
    priority { '低' }
  end
end