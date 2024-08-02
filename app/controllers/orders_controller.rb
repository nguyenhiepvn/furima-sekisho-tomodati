class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
 
  def index
    @order = Order.new
    @order.build_address
    gon.public_key = ENV['PAYJP_PUBLIC_KEY'] # Payjpの公開鍵をgonに設定
  end
 
  def create
    @order = Order.new(order_params)
    if @order.save
      # 決済処理を行う
      pay_item
      redirect_to root_path, notice: '購入が完了しました'
    else
      render :index
    end
  end
 
  private
 
  def order_params
    params.require(:order).permit(:item_id, address_attributes: [:postal_code, :prefecture_id, :city, :address, :building, :phone_number]).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
 
  def set_item
    @item = Item.find(params[:item_id])
  end
 
  def pay_item
    # PayjpのAPIキーを設定
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 日本円
    )
  end
end