require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名', with:'万葉課題'
        fill_in '内容', with: 'STEP1'
        click_on "新規作成"
        expect(page).to have_content '万葉課題'
      end
    end
  end
  describe '一覧表示機能' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'test_title'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content "万葉課題"
      end
    end
  end
  describe 'ソート機能' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:third_task) { FactoryBot.create(:third_task) }
    before do
      visit tasks_path
    end
    context '終了期限でソートするボタンを押した場合' do
      it '終了期限が遅いタスクが一番上に表示される' do
        click_on "終了期限でソートする"
        task_list = all('.task_row')
        puts task_list[0]
        expect(task_list[0]).to have_content "テスト確認"
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        visit tasks_path
        task = FactoryBot.create(:task, title: 'show')
        visit tasks_path
        expect(page).to have_content 'show'
       end 
     end
  end
end