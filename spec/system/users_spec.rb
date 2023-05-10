require 'rails_helper'

RSpec.describe "Users", type: :system do
  
  let(:user) { FactoryBot.create(:user) }


  describe 'ログイン' do
    before do
      visit new_user_session_path
    end

    context 'ログイン情報を入力するとき' do
      it 'ログインできること' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
        expect(page).to have_content 'Signed in successfully.'
      end

      it '不正なログイン情報を入力するとき' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: 'invalid_password'
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
        fill_in "user[username]", with: user.username
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        fill_in "user[password_confirmation]", with: user.password
        click_button "Sign up"
      end

      it "新規登録成功後の遷移先が正しいこと" do
        expect(current_path).to eq "/users"
      end
    end

    context "新規登録に失敗した場合" do
      before do
        fill_in "user[username]", with: user.username
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: "sample_password"
        fill_in "user[password_confirmation]", with: "sample_password2"
        click_button "Sign up"
      end
            
      it "新規登録失敗後の遷移先が正しいこと" do
        expect(current_path).to eq "/users"
      end
    end
    

  end

end
