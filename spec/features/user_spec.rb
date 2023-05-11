# frozen_string_literal: true

# spec/features/user_spec.rb

require 'rails_helper'

RSpec.feature 'User', type: :feature do
  background do
    User.create(username: 'test', email: 'test@example.com', password: 'password')
  end

  scenario 'サインアップする' do
    visit new_user_registration_path
    fill_in 'Username', with: 'test2'
    fill_in 'Email', with: 'test2@example.com'
    fill_in 'Password', with: 'password2', match: :first
    fill_in 'Password confirmation', with: 'password2', match: :first
    click_button 'Sign up'
    expect(page).to have_current_path root_path
  end

  scenario 'ログインする' do
    visit new_user_session_path
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
