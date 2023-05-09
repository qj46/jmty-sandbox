require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'ログイン' do
    before do
      visit new_user_session_path
    end

    context '正しいログイン情報を入力するとき' do
      it 'ログインできること' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
        expect(page).to have_content 'Signed in successfully.'
      end
    end

    context '不正なログイン情報を入力するとき' do
      it 'ログインできないこと' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'invalid_password'
        click_button 'Log in'
        expect(page).to have_content 'Invalid Email or password.'
      end
    end
  end
end
