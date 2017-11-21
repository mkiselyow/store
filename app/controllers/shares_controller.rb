class SharesController < ApplicationController
  def index
    @shares = Share.order(:id)
  end
end
