class OrderItemsController < ApplicationController

  # POST /order_items/new
  def create
    @order = Order.first_or_create(status: 'pending')
    @order_item = @order.order_items.new(order_item_params)

    respond_to do |format|
      unless @order.save
        format.html { redirect_to items_path, notice: "Something went wrong" }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }

        return
      end

      if @order_item.has_item?
        format.html { redirect_to items_path, notice: "#{@order_item.item.name} added to pending order" }
        format.json { render :show, status: :created, location: @items_path }
      elsif @order_item.has_assembly?
        format.html { redirect_to assemblies_path, notice: "#{@order_item.assembly.name} added to pending order" }
        format.json { render :show, status: :created, location: @assemblies_path }
      end
    end
  end

  def delete
    puts "delete"
  end

  private

  def order_item_params
    params.require(:order_item).permit(:item_id, :assembly_id, :status)
  end
end
