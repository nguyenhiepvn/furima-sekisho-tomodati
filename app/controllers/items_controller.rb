class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :destroy, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :update, :edit]
  before_action :redirect_edit, only: [:edit]

  def index
    @items = Item.order("created_at DESC")
  end  
  
  def show
  end

  def edit
    unless @item.user == current_user
      redirect_to action: :index
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit , status: :unprocessable_entity
    end
  end

  def search
    @q = Item.ransack(params[:q])
    
    if params[:q].present? && params[:q].values.any?(&:present?)
      @items = @q.result
    else
      @items = [] # 検索クエリが空の場合は空の配列を設定
    end
  end
  
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to root_path
    else
      render :new, locals: { item: @item }, status: :unprocessable_entity
    end
  end

  def destroy

    if current_user.id == @item.user_id
      @item.destroy
      flash[:notice] = "商品が削除されました。"
    end
    redirect_to root_path # 条件に関係なく、削除後はトップページにリダイレクトします
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :condition_id, :postage_payer_id, :prefecture_id, :preparation_day_id, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
 
  def redirect_edit
    if @item.sold? && @item.user == current_user
      redirect_to root_path
    end
  end
 
end