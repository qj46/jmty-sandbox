# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'ログイン処理' do
    before do
      User.create(username: 'test', email: 'test@example.com', password: 'password')
    end

    context 'ログインに成功した場合' do
      it 'ログインできたことを知らせる' do
        visit new_user_session_path
        fill_in 'メール', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_current_path root_path
        expect(page).to have_content 'ログインしました。'
      end
    end

    context 'ログインに失敗した場合' do
      it 'ログイン情報に誤りがあることを知らせる' do
        visit new_user_session_path
        fill_in 'メール', with: 'test@example.com'
        fill_in 'パスワード', with: 'invalid_password'
        click_button 'ログイン'
        expect(page).to have_current_path new_user_session_path
        expect(page).to have_content 'メール もしくはパスワードが不正です。'
      end
    end
  end

  describe '新規登録処理' do
    context '新規登録に成功した場合' do
      it '新規登録成功後の遷移先が正しい' do
        visit new_user_registration_path
        fill_in '名前', with: 'test'
        fill_in 'メール', with: 'test@example.com'
        fill_in 'パスワード', with: 'password', match: :first
        fill_in '確認用パスワード', with: 'password', match: :first
        click_button '登録'
        expect(page).to have_current_path root_path
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
    end

    context '新規登録に失敗した場合' do
      # おそらく他のケースも
      it 'パスワード登録失敗後の遷移先が正しい' do
        visit new_user_registration_path
        fill_in '名前', with: 'test'
        fill_in 'メール', with: 'test@example.com'
        fill_in 'パスワード', with: 'password', match: :first
        fill_in '確認用パスワード', with: 'password2', match: :first
        click_button '登録'
        expect(page).to have_current_path '/users'
        expect(page).to have_content '確認用パスワードとパスワードの入力が一致しません'
      end
    end
  end
end
