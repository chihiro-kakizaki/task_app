require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名', with:'万葉課題'
        fill_in '内容', with: 'STEP1'
        select Time.current.year + 5, from: 'task[expired_at(1i)]'
        select '未着手', from: 'task[status]'
        click_on "新規作成"
        expect(page).to have_content '未着手'
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
    context '優先順位でソートするボタンを押した場合' do
      it '優先順位が高いタスクが一番上に表示される' do
        click_on "優先順位でソートする"
        task_list = all('.task_row')
        puts task_list[0]
        expect(task_list[0]).to have_content "高"
      end
    end
  end
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    before do
      visit tasks_path
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in task[title], with: 'test'
        click_on "検索"
        expect(page).to have_content 'test_title'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '着手中', from: 'task[status]'
        click_on "検索"
        expect(page).to have_content 'STEP3'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in task[title], with: '万葉'
        select '着手中', from: 'task[status]'
        click_on "検索"
        expect(page).to have_content 'STEP3'
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