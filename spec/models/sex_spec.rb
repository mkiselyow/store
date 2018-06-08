require 'rails_helper'

RSpec.describe Sex, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:products) }
  end
end
