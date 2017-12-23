class ApplicationController < ActionController::Base
  include CurrentCart
  before_action :set_cart
  protect_from_forgery with: :exception
  before_action :banned?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :set_tags

  def banned?
    return unless current_user.present? && current_user.banned?

    sign_out current_user
    redirect_to root_path, notice: 'Вы добавлены в чёрный список сайта!'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email first_name last_name email number admin avatar username banned])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email first_name last_name email number admin avatar username banned])
    devise_parameter_sanitizer.permit(:login, keys: [:email])
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user == @user
  end

  def only_admin_access
    redirect_to(root_url) unless current_user && current_user.admin?
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }
  end

  def set_tags
    set_meta_tags title: 'Мапапама - Подари ребёнку радость :)',
                  description: 'Интернет магазин детских игрушек Мапапама',
                  keywords: 'мапапама уа, мапапама купить украина, мапапама юа интернет магазин, 
                         мапапама магазин, мапапама купить, Мапапама, Mapapama, 
                         мапапама интернет магазин, мапапама игрушки, ьфзфзфьф,
                        мапапама ком юа, vfgfgfvf rjv .f, mapapama.com.ua, мама папа,
                        папа мама, мапапама.ком.юа, мамапапа ком юа, мама папа ком,
                        mapapama.com, мапапама ком, мапапама.ком, mapapama.ua,
                        мапапама юа,www.mapapama.com.ua, www.mapapama.com,
                        www.mapapama.ua, Игрушки, Игрушки купить, Игрушки заказать,
                        Детские игрушки, Детские игрушки купить Детские игрушки заказать, Игрушки детские,
                        Игрушки детские купить, Игрушки детские заказать, Игрушки детям. Игрушки детям купить,
                        Игрушки детям заказать, Игрушки для детей, Игрушки для детей купить, Игрушки для детей заказать,
                        Купить игрушки, Купить детские игрушки, Купить игрушки детям, Интерне-магазин, Интернет магазин,
                        Детский интернет-магазин, Детский интернет-магазин, Интернет-магазин для детей,
                        Интернет магазин для детей, Игрушки онлайн, Игрушки онлайн купить, Детские товары, 
                        Детские товары купить, Детские товары онлайн, Интернет-магазин детских товаров, 
                        Интернет магазин детских товаров, Где купить детские игрушки, Где купить детям,
                        Где купить детские товары, Где купить детские игрушки в Украине'
  end
end
