# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    context '使用禁止のアカウント名に該当しない場合' do
      it 'アカウントは有効' do
        user = build(:user, username: 'foobar')
        expect(user).to be_valid
      end
    end

    context '使用禁止のアカウント名に該当する場合' do
      it 'アカウントは無効' do
        user = build(:user, username: 'admin')
        expect(user).not_to be_valid

        # user = build(:user, username: 'root')
        user.username = 'root'
        expect(user).not_to be_valid

        # user = build(:user, username: 'dashboard')
        user.username = 'dashboard'
        expect(user).not_to be_valid

        user = build(:user, username: 'analytics')
        # expect(user).not_to be_valid
        expect(user).not_to be_invalid

        user = build(:user, username: 'appearance')
        expect(user).not_to be_valid

        user = build(:user, username: 'settings')
        expect(user).not_to be_valid

        user = build(:user, username: 'preferences')
        expect(user).not_to be_valid

        user = build(:user, username: 'calendar')
        expect(user).not_to be_valid
      end
    end
  end

  describe 'friendly_id' do
    let(:user) { create(:user, username: 'test') }

    context 'ユーザー名が変わる場合' do
      it 'ユーザー名とスラッグが変わる' do
        # before
        expect(user.slug).to eq 'test'
        # after
        user.update!(username: 'new-test')
        expect(user.slug).to eq 'new-test'

        # 高等テクニック　上記と同じ
        expect {
          user.update!(username: 'new-test')
        }.to change { user.slug }.from('test').to('new-test')
      end
    end
  end
end
