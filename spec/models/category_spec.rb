require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:products).dependent(:destroy) } 
  end

  describe 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:subcategories) }
  end
end
