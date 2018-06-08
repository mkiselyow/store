require 'rails_helper'

RSpec.describe UsefulArticle, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:category_post) } 
    it { is_expected.to belong_to(:user) } 

    it { is_expected.to have_many(:comment_posts).dependent(:destroy) }
  end
end
