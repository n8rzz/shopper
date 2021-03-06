# frozen_string_literal: true

class OrderItemsController < ApplicationController
  before_action :set_pending_order, only: [:create_assembly, :create_item]

  #  POST /order_items/create/assembly
  #  POST /order_items/create/assembly.json
  def create_assembly
    assembly = Assembly.find(order_item_params[:assembly_id])

    assembly.items.each do |item|
      @order.order_items << OrderItem.new(
        # TODO: this can probably be removed
        order_id: @order.id,
        assembly_id: assembly.id,
        item_id: item.id,
        department_id: item.department.id
      )
    end

    respond_to do |format|
      unless @order.save
        format.html { redirect_to assemblies_path, notice: 'Something went wrong' }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }

        return
      end

      format.html { redirect_to assemblies_path, notice: "#{assembly.name} added to pending order" }
      format.json { render json: @order_item, status: :created }
    end
  end

  # POST /order_items/create/item
  def create_item
    @order_item = @order.order_items.new(order_item_params)

    respond_to do |format|
      unless @order.save
        format.html { redirect_to items_path, notice: 'Something went wrong' }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }

        return
      end

      format.html { redirect_to items_path, notice: "#{@order_item.item.name} added to pending order" }
      format.json { render json: @order_item, status: :created }
    end
  end

  # PATCH/PUT /order_items/1
  # PATCH/PUT /order_items/1.json
  def update
    @order_item = OrderItem.find(params[:id])

    respond_to do |format|
      if @order_item.update(order_item_params)
        # format.html { redirect_to @order_item, notice: 'Order was successfully updated.' }
        format.json { render json: @order_item, status: :ok }
      else
        # format.html { render :edit }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_items/1
  def delete
    @order_item = OrderItem.find(params[:id])

    respond_to do |format|
      if @order_item.destroy
        format.json { head :no_content }
      else
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:item_id, :assembly_id, :department_id, :picked, :status, :qty)
  end

  def set_pending_order
    @order = Order.find_or_initialize_by(status: 'pending')

    return if @order.shopping_date.nil?

    @order.shopping_date = Time.now
  end
end
