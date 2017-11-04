class User < ApplicationRecord
  validates :number, uniqueness: { message: 'Такой номер уже зарегестрирован' }
  validates :number, presence: { message: 'Укажите Ваш контактный номер телефона' }, format: { with: /(\A\+3([ -])?8([ -])?0[1-9]{2}([ -])?(\d([ -])?){7}\z)|(\A0([ -])?[1-9]{2}([ -])?(\d([ -])?){7}\z)/x, message: 'Введите номер телефона в формате +380971234567' }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook instagram]

  # avatar
  has_many :comments, dependent: :destroy
  # has_attached_file :avatar, styles: { medium: '100x100>', thumb: '50x50>' }
  # validates_attachment_content_type :avatar, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  validates_presence_of  :avatar
  mount_uploader :avatar, AvatarUploader
  # omniauth
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      # user.username = auth.data.username
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
