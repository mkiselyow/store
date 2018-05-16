class Admin::ApplicationController < ActionController::Base
  before_filter :set_cache
  
  def set_cache
    response.headers["Cache-Control"] ="public, max-age=#{10.days.seconds.to_i}"
    response.headers["Expires"] = "#{10.days.from_now.to_formatted_s(:rfc822)}"
  end
end
