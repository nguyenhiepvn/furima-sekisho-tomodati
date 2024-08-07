class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :seller_to_root
  before_action :soldout_to_root, only: [:index, :create]
 
  def index
    @order_address = OrderAddress.new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end
 
  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      return redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def seller_to_root
    redirect_to root_path if current_user.id == @item.user.id
  end

  def soldout_to_root
    redirect_to root_path if @item.orders.exists?
  end


  def order_address_params
    params.require(:order_address).permit(:item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
 
  def pay_item

    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_address_params[:token], # カードトークン
      currency: 'jpy' # 日本円
    )
  end
end