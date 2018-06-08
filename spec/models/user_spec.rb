require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:comments).dependent(:destroy) } 
    it { is_expected.to have_many(:comment_posts).dependent(:destroy) } 
    it { is_expected.to have_many(:useful_articles).dependent(:destroy) }
    it { is_expected.to have_many(:orders).dependent(:destroy) }
    it { is_expected.to have_many(:user_views).dependent(:destroy) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:role) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe '#full_name' do
    let(:user) { create(:user) }

    it 'is full name' do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end
end
