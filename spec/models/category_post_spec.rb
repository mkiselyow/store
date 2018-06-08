require 'rails_helper'

RSpec.describe CategoryPost, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:useful_articles).dependent(:destroy) }
  end
end
