require 'rails_helper'

RSpec.describe CommentPost, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) } 
    it { is_expected.to belong_to(:useful_article) } 
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:body) } 
  end
end
