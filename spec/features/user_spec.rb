# frozen_string_literal: true

# spec/features/user_spec.rb

require 'rails_helper'

RSpec.feature 'User', type: :feature do
  background do
    User.create(username: 'test', email: 'test@example.com', password: 'password')
  end

  scenario 'サインアップする' do
    visit new_user_registration_path
    fill_in '名前', with: 'test2'
    fill_in 'メール', with: 'test2@example.com'
    fill_in 'パスワード', with: 'password2', match: :first
    fill_in '確認用パスワード', with: 'password2', match: :first
    click_button 'Sign up'
    expect(page).to have_current_path root_path
  end

  scenario 'ログインする' do
    visit new_user_session_path
    fill_in 'メール', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'Log in'
    expect(page).to have_content 'ログインしました。'
  end
end
