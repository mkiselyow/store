require 'rails_helper'

RSpec.describe ImageProduct, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:product) } 
  end
end
