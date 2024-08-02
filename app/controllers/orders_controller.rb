class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :check_item_accessibility, only: [:index, :create]
 
  def index
    @order = Order.new
    @order.build_address
    gon.public_key = ENV['PAYJP_PUBLIC_KEY'] 
  end
 
  def create
    @order = Order.new(order_params.except(:address_attributes))
    @order.user_id = current_user.id
    @order.item_id = params[:item_id]
    @order.token = params[:token]
    if @order.save && @order.build_address(order_params[:address_attributes]).save && pay_item
      redirect_to root_path, notice: '購入が完了しました'
    else
      flash[:alert] = '決済処理に失敗しました'
      render :index
    end
  end
 
  private

  def check_item_accessibility
    if user_signed_in?
    if @item.user == current_user
      redirect_to root_path, alert: '自分が出品した商品は購入できません。'
      elsif @item.sold?
      redirect_to root_path, alert: 'この商品は売却済みです。'
      end
    else
      redirect_to new_user_session_path, alert: 'ログインが必要です。'
    end
  end
 
  def order_params
    params.require(:order).permit(:item_id, address_attributes: [:postal_code, :prefecture_id, :city, :address, :building, :phone_number]).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
 
  def set_item
    @item = Item.find(params[:item_id])
  end
 
  def pay_item
    begin
    # PayjpのAPIキーを設定
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 日本円
    )
    true
    rescue Payjp::PayjpError => e
      logger.error "Payment error: #{e.message}"
      false
    end
  end
end