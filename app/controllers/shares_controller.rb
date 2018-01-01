class SharesController < ApplicationController
  def index
    @shares = Share.last_five_offers
  end

  def show
    @share = Share.find(params[:id])
  end
end
