# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'validation' do
    context '登録出来ない場合' do
      it '使えないアカウント名は登録出来ない' do
        # Act, Assert
        
        # admin
        user = build(:user, username: "admin")
        expect(user).not_to be_valid

        # root
        user = build(:user, username: "root")
        expect(user).not_to be_valid

        # dashboard
        user = build(:user, username: "dashboard")
        expect(user).not_to be_valid

        # analytics
        user = build(:user, username: "analytics")
        expect(user).not_to be_valid

        # appearance
        user = build(:user, username: "appearance")
        expect(user).not_to be_valid

        # settings
        user = build(:user, username: "settings")
        expect(user).not_to be_valid

        # preferences
        user = build(:user, username: "preferences")
        expect(user).not_to be_valid

        # calendar
        user = build(:user, username: "calendar")
        expect(user).not_to be_valid
      end
    end
  end

  describe 'friendly_id' do
    # Arrange
    let(:user) { create(:user, username: 'test') }

    context 'ユーザー名が変わる場合' do
      it 'ユーザー名とスラッグが変わる' do
        # Act        
        user.update(username: 'new-test')

        # Assert
        expect(user.slug).to eq('new-test')
      end
    end
  end
end
