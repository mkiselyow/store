class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[vkontakte facebook instagram google_oauth2]

  has_many :comments, dependent: :destroy
  has_many :comment_posts, dependent: :destroy
  has_many :useful_articles, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :user_views, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.remote_avatar_url = auth.info.image
      user.save!
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
