class ItemsController < ApplicationController
  def index
  end

  def update
  end

  def show
  end

  def new
    @item = Item.new
    #セレクトボックスの選択肢を格納する配列を定義
    @category_parent_array = []
      #データベースから、親カテゴリーのみ抽出し、配列化→where(ancestry: nil)で親要素のみを取得することができる
      Category.where(ancestry: nil).each do |parent|
          @category_parent_array << parent.name
      end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '出品完了しました'
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description)
  end

end
