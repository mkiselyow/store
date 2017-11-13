class CartsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def index
    @carts = Cart.all
  end

  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Корзина была успешно обновлена' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params.fetch(:cart, {})
  end

  def invalid_cart
    logger.error "Попытка доступа к неправльной корзине #{params[:id]}"
    redirect_to root_url, notice: 'Неверная корзина'
  end
end
