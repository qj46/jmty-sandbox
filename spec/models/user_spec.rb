# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    context '登録出来る場合' do
      it '使えるアカウント名は登録出来る' do
        user = build(:user, username: 'foobar')
        expect(user).to be_valid
      end
    end

    context '登録出来ない場合' do
      it '使えないアカウント名は登録出来ない' do
        user = build(:user, username: 'admin')
        expect(user).not_to be_valid

        user = build(:user, username: 'root')
        expect(user).not_to be_valid

        user = build(:user, username: 'dashboard')
        expect(user).not_to be_valid

        user = build(:user, username: 'analytics')
        expect(user).not_to be_valid

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
        user.update(username: 'new-test')
        expect(user.slug).to eq('new-test')
      end
    end
  end
end
