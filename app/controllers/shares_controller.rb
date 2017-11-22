class SharesController < ApplicationController
  def index
    @shares = Share.order('id DESC').limit(5)
  end

  def show
    @share = Share.find(params[:id])
  end
end
