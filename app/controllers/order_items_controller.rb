class OrderItemsController < ApplicationController

  # POST /order_items/new
  def create
    @order = Order.first_or_create(status: 'pending')
    @order_item = @order.order_items.new(order_item_params)
    session[:order_id] = @order.id

    respond_to do |format|
      # FIXME: make this less gross
      if @order.save && order_item_params[:item_id] != nil
        format.html { redirect_to items_path, notice: "#{@order_item.item.name} added to pending order" }
        format.json { render :show, status: :created, location: @items_path }
      elsif @order.save && order_item_params[:assembly_id] != nil
        format.html { redirect_to assemblies_path, notice: "#{@order_item.assembly.name} added to pending order" }
        format.json { render :show, status: :created, location: @assemblies_path }
      else
        format.html { redirect_to items_path }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    puts "delete"
  end

  private

  def order_item_params
    params.require(:order_item).permit(:item_id, :assembly_id)
  end
end
