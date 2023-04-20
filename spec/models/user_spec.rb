require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'validations' do
    context 'when full_name exceeds maximum length' do
      let(:user) { build(:user, full_name: Faker::Lorem.characters(number: 51)) }
      
      it 'is invalid' do
        expect(user).not_to be_valid
        expect(user.errors[:full_name]).to include('is too long (maximum is 50 characters)')
      end
    end
    
    context 'when body exceeds maximum length' do
      let(:user) { build(:user, body: Faker::Lorem.characters(number: 81)) }
      
      it 'is invalid' do
        expect(user).not_to be_valid
        expect(user.errors[:body]).to include('is too long (maximum is 80 characters)')
      end
    end
    
    context 'when username is invalid' do
      before { create(:user, username: 'taken_username') }
      
      it 'should be invalid if username is already taken' do
        user = build(:user, username: 'taken_username')
        expect(user).not_to be_valid
        expect(user.errors[:username]).to include('is already taken')
      end
      
      it 'should be invalid if username is restricted' do
        restricted_usernames = %w[admin root dashboard analytics appearance settings preferences calendar]
        
        restricted_usernames.each do |username|
          user = build(:user, username: username)
          expect(user).not_to be_valid
          expect(user.errors[:username]).to include('is restricted')
        end
      end
    end
  end
  
  describe 'friendly_id' do
    let(:user) { create(:user, username: 'test-username') }
    
    it 'should generate slug when username changes' do
      expect(user.slug).to eq('test-username')
      user.update(username: 'new-test-username')
      expect(user.slug).to eq('new-test-username')
    end
  end
  
end
