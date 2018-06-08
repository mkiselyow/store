require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:sex) }

    it { is_expected.to have_many(:image_products).dependent(:destroy) }
    it { is_expected.to have_many(:line_items).dependent(:destroy) }
    it { is_expected.to have_many(:orders).through(:line_items) }
    it { is_expected.to have_many(:user_views).dependent(:destroy) }
  end

  describe 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:image_products) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
