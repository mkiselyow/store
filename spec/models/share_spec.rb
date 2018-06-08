require 'rails_helper'

RSpec.describe Share, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) } 
  end

  describe '#last_five_offers' do
    let(:user) { create(:user) }
    let!(:shares) { create_list(:share, 6, user: user) }

    it { expect(Share.last_five_offers.count).to eq 5 } 
  end
end
