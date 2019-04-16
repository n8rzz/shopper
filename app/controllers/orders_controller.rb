class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all.order('status DESC')
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order_items_by_concern = nil
    @should_show_non_grouped = false

    if params[:order] == 'assembly'
      @order_items_by_concern = @order.group_by_assembly
      @should_show_non_grouped = true
    elsif params[:order] == 'department'
      @order_items_by_concern = @order.group_by_department_and_sort
    end
  end

  # GET /orders/new
  def new
    @order = Order.new(shopping_date: Time.now)
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_path, notice: 'Order was created successfully' }
        format.json { render :show, status: :created, location: orders_path }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was updated successfully' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /orders/1/duplicate
  # POST /orders/1/duplicate.json
  def duplicate
    order = Order.find(params[:order_id])
    duplicate_order = order.duplicate

    respond_to do |format|
      if duplicate_order != nil && duplicate_order.save
        format.html { redirect_to edit_order_url(duplicate_order.id), notice: 'Order duplicated successfully' }
        format.json { render :show, status: :created, location: orders_path }
      else
        format.html { redirect_to edit_order_url(order.id) }
        format.json { render :show, status: :created, location: orders_path }
      end
    end
  end

  # DELETE /orders/1/assembly/1
  # DELETE /orders/1/assembly/1.json
  def delete_assembly
    order = Order.find(params[:order_id])

    respond_to do |format|
      if order.delete_assembly(params[:assembly_id])
        format.html { redirect_to order_url(order.id), notice: 'Assembly deleted successfully' }
        format.json { render :show, status: 204, location: orders_path }
      else
        format.html { redirect_to order_url(order.id) }
        format.json { render :show, status: 204, location: orders_path }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:status, :location_id)
    end
end
