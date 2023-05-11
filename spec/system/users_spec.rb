require 'rails_helper'

RSpec.describe "Users", type: :system do
  

  describe 'ログイン' do
    before do
      User.create(username: "test", email: "test@example.com", password: "password")
      visit new_user_session_path
    end

    context 'ログイン情報を入力するとき' do
      it 'ログインできること' do
        fill_in 'Email', with: "test@example.com"
        fill_in "Password", with: "password"
        click_button 'Log in'
        expect(page).to have_content 'Signed in successfully.'
      end

      it '不正なログイン情報を入力するとき' do
        fill_in 'Email', with: "test@example.com"
        fill_in 'Password', with: 'invalid_password'
        click_button 'Log in'
        expect(page).to have_content 'Invalid Email or password.'
      end
    end
  end


  describe "新規登録" do
    before do
      visit new_user_registration_path
    end
    
    context "新規登録に成功した場合" do
      before do
        fill_in "Username", with: "test"
        fill_in "Email", with: "test@example.com"
        fill_in "Password", with: "password", match: :first
        fill_in "Password confirmation", with: "password", match: :first
        click_button "Sign up"
      end

      it "新規登録成功後の遷移先が正しいこと" do
        expect(page).to have_current_path root_path
      end
    end

    context "新規登録に失敗した場合" do
      before do
        fill_in "Username", with: "test"
        fill_in "Email", with: "test@example.com"
        fill_in "Password", with: "password", match: :first
        fill_in "Password confirmation", with: "password2", match: :first
        click_button "Sign up"
      end
            
      it "新規登録失敗後の遷移先が正しいこと" do
        expect(page).to have_current_path "/users"
      end

      
    end
    
  end

end
