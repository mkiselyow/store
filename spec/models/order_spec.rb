require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe '#full_name' do
    let(:order) { create(:order) }

    it 'is full name' do
      expect(order.full_name).to eq("#{order.first_name} #{order.last_name}")
    end
  end
end
