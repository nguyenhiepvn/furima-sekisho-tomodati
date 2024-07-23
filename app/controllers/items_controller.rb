class ItemsController < ApplicationController
  def index
  end  # rubocop:disable Layout/TrailingWhitespace
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to root_path
    else
      @item.image= nil
      
      render :new,locals:{item: @item}, status: :unprocessable_entity
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :condition_id, :postage_payer_id, :prefecture_id, :preparation_day_id, :image)
  end
end
