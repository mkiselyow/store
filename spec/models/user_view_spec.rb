require 'rails_helper'

RSpec.describe UserView, type: :model do
  let(:user) { create(:user) }

  describe 'associations' do
    it { is_expected.to belong_to(:product) } 
    it { is_expected.to belong_to(:user) } 
  end

  describe 'validates' do
    let(:product) { create(:product) }
    let!(:user_view) { create(:user_view, user: user, product: product) }

    it 'must be uniquness for each user' do
      user_view_2 = user.user_views.new(product: product)
      expect(user_view_2.valid?).to eq false
    end
  end

  describe '#last_six_views' do
    let!(:user_views) { create_list(:user_view, 8, user: user) }

    it { expect(UserView.last_six_views.count).to eq 6 } 
  end
end
