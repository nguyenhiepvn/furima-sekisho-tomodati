class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def index
    @order = Order.new
  end

  # def index
  #   @order = Order.index
  # end
  
  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to root_path, notice: '購入が完了しました。'
    else
      render :index
    end
  end
 
  private
 
  def set_item
    @item = Item.find(params[:item_id])
  end
 
  def order_params
    params.require(:order).permit(address_attributes: [:postal_code, :prefecture_id, :city, :address, :building, :phone_number]).merge(user_id: current_user.id, item_id: @item.id)
  end
end
