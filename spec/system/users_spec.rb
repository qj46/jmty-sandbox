require 'rails_helper'

RSpec.describe "Users", type: :system do
  

  describe 'ログイン処理' do
    # Arrange
    before do
      User.create(username: "test", email: "test@example.com", password: "password")
    end

    context 'ログインに成功した場合' do
      it 'ログインできたことを知らせる' do
        # Act
        visit new_user_session_path

        fill_in 'Email', with: "test@example.com"
        fill_in "Password", with: "password"
        click_button 'Log in'
        # Assert
        expect(page).to have_content 'Signed in successfully.'
      end
    end

    context 'ログインに失敗した場合' do
      it 'ログイン情報に誤りがあることを知らせる' do
        # Act
        visit new_user_session_path

        fill_in 'Email', with: "test@example.com"
        fill_in 'Password', with: 'invalid_password'
        click_button 'Log in'
        # Assert
        expect(page).to have_content 'Invalid Email or password.'
      end
    end
  end


  describe "新規登録処理" do    
    context "新規登録に成功した場合" do
      it "新規登録成功後の遷移先が正しい" do
        # Act
        visit new_user_registration_path

        fill_in "Username", with: "test"
        fill_in "Email", with: "test@example.com"
        fill_in "Password", with: "password", match: :first
        fill_in "Password confirmation", with: "password", match: :first
        click_button "Sign up"
        # Assert
        expect(page).to have_current_path root_path
      end
    end

    context "新規登録に失敗した場合" do      
      it "新規登録失敗後の遷移先が正しい" do
        # Act
        visit new_user_registration_path

        fill_in "Username", with: "test"
        fill_in "Email", with: "test@example.com"
        fill_in "Password", with: "password", match: :first
        fill_in "Password confirmation", with: "password2", match: :first
        click_button "Sign up"
        # Assert
        expect(page).to have_current_path "/users"
      end
    end
  end
  
end
