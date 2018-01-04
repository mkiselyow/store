class LineItemsController < ApplicationController
  include CurrentCart

  before_action :set_line_item, only: %i[show edit update destroy]

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_back(fallback_location: root_path, notice: 'Товарная позиция создана.') }
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
    @line_item.destroy!
  end

  def decrease_quantity
    @line_item = LineItem.find(params[:line_item_id])
    if @line_item.quantity >= 2
      decreased_quantity = @line_item.quantity - 1
      @line_item.update(quantity: decreased_quantity)
    else
      @line_item.destroy!
    end
  end

  def increase_quantity
    @line_item = LineItem.find(params[:line_item_id])
    if @line_item
      increased_quantity = @line_item.quantity + 1
      @line_item.update(quantity: increased_quantity)
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
