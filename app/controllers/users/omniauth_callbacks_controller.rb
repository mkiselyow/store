class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :omniauth_request

  def facebook
    if @user.present?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    if @user.present?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Google +') if is_navigational_format?
    else
      redirect_to new_user_registration_url
    end
  end

  private

  def omniauth_request
    @user = User.from_omniauth(request.env['omniauth.auth'])
  end
end
