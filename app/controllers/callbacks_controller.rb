class CallbacksController < Devise::OmniauthCallbacksController
  before_action :user_resource, only: %i[facebook instagram vk]

  def facebook; end

  def instagram; end

  def vk; end

  private

  def user_resource
    @user = User.from_omniauth(request.env['omniauth.auth'])
    sign_in_and_redirect @user
  end
end
