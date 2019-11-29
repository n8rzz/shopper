class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @item = current_owner.items.new
    @items = current_owner.items.by_name
    @departments = current_owner.departments.by_name
    @order_item = OrderItem.new
    @items_by_concern = nil
  end

  # GET /items/new
  def new
    @item = current_owner.items.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = current_owner.items.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to items_path, notice: 'Item was created successfully' }
        format.json { render :show, status: :created, location: items_path }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to items_path, notice: 'Item was updated successfully' }
        format.json { render :show, status: :ok, location: items_path }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = current_owner.items.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :department_id, order_item_ids:[], assembly_item_ids:[])
    end
end
