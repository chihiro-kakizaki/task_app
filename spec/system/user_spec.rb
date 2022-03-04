require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザー登録機能' do
    context 'ユーザーを新規登録した場合' do
      it '作成したユーザーが表示される' do
        visit new_user_path
        fill_in 'ユーザー名', with: 'test'
        fill_in 'メールアドレス', with: 'test@gmail.com'
        fill_in 'パスワード', with: '1111'
        fill_in 'パスワード確認', with: '1111'
        click_on '新規作成'
        expect(page).to have_content 'test@gmail.com'
      end
      it 'ログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移'do
        visit tasks_path
        expect(current_path). to eq new_session_path
      end
    end
  end
  describe 'セッション機能' do
    let!(:user){ FactoryBot.create(:user) }
    let!(:second_user){ FactoryBot.create(:second_user) }
    let!(:task){ FactoryBot.create(:task,user: user) }
    before do
      visit new_session_path
      fill_in "session_email", with: 'general@gmail.com'
      fill_in "session_password", with: '1111'
      click_on 'Log in'
    end
    context 'ログインした場合' do
      it 'ログイン成功' do
        expect(page).to have_content '一般'
      end
      it 'マイページに遷移' do
        click_on "Profile"
        expect(page).to have_content '一般'
      end
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移' do
        visit user_path(user.id)
        expect(current_path).to eq tasks_path
      end
      it 'ログアウトできる' do
        click_on "Logout"
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe '管理機能' do
    let!(:user){ FactoryBot.create(:user) }
    let!(:second_user){ FactoryBot.create(:second_user) }
    let!(:task){ FactoryBot.create(:task,user: user) }
    before do
      visit new_session_path
      fill_in "session_email", with: 'admin@gmail.com'
      fill_in "session_password", with: '1111'
      click_on 'Log in'
      click_on "管理者ページ"
    end
    context '管理ユーザーの場合' do
      it '管理画面にアクセスできる' do
        expect(page).to have_content "ユーザー一覧を表示"
      end
      it 'ユーザの新規登録ができる' do
        click_on "新規作成"
        fill_in 'ユーザー名', with: 'test'
        fill_in 'メールアドレス', with: 'test@gmail.com'
        fill_in 'パスワード', with: '1111'
        fill_in 'パスワード確認', with: '1111'
        click_on "Create my account"
        expect(page).to have_content 'test@gmail.com'
      end
      it 'ユーザーの詳細画面にアクセスできる' do
        all("tbody tr")[0].click_on "詳細"
        expect(page).to have_content '管理者のタスク一覧'
      end
      it 'ユーザーの編集画面から編集できる' do
        all("tbody tr")[0].click_on "編集"
        fill_in 'ユーザー名', with: '別ユーザー'
        click_on "編集"
        expect(page).to have_content '別ユーザー'
      end   
      it 'ユーザーを削除できる' do
        all("tbody tr")[1].click_on "削除"
        expect(page).to have_content "ユーザーを削除しました"
      end
    end
    context '一般ユーザーの場合' do
      it '管理画面へアクセスできない' do
        click_on 'Logout'
        fill_in "session_email", with: 'general@gmail.com'
        fill_in "session_password", with: '1111'
        click_on 'Log in'
        visit admin_users_path
        expect(page).to have_content "管理者以外アクセスできません"
      end

    end
  end  
end