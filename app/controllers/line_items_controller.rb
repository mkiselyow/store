class LineItemsController < ApplicationController
  include CurrentCart
  # before_action :set_cart, only: [:create]
  before_action :set_line_item, only: %i[show edit update destroy]

  def index
    @line_items = LineItem.order(:id)
  end

  def new
    @line_item = LineItem.new
  end

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to root_url, notice: 'Товарная позиция создана.' }
        format.js { @current_item = @line_item }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Товарная позиция успешно обновлена.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to @line_item.cart, notice: 'Товар был успешно убран из корзины' }
      format.json { head :no_content }
    end
  end

  def decrease_quantity
    @line_item = LineItem.find(params[:line_item_id])
    if @line_item.quantity >= 2
      decreased_quantity = @line_item.quantity - 1
      @line_item.update(quantity: decreased_quantity)
      respond_to do |format|
        format.html { redirect_to cart_path(@line_item.cart_id), notice: 'Количество было успешно уменьшено' }
        format.json { head :no_content }
      end
    else
      @line_item.destroy
      # redirect_to :back, notice: 'Товар был успешно убран из корзины'
      respond_to do |format|
        format.html { redirect_to cart_path(@line_item.cart_id), notice: 'Товар был успешно убран из корзины' }
        format.json { head :no_content }
      end
    end
  end

  def increase_quantity
    @line_item = LineItem.find(params[:line_item_id])
    if @line_item
      increased_quantity = @line_item.quantity + 1
      @line_item.update(quantity: increased_quantity)
      respond_to do |format|
        format.html { redirect_to cart_path(@line_item.cart_id), notice: 'Количество было успешно увеличено' }
        format.json { head :no_content }
      end
    else
      format.html { redirect_to cart_path(@line_item.cart_id), notice: 'Неизвестная ошибка' }
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:product_id)
  end
end
