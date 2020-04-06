class ItemsController < ApplicationController

  before_action :ensure_correct_user,{only: [:edit,:buy,]} 
  

  def index
    @items = Item.all
    @images = Image.all
    @item = Item.new

  end

  def update
  end

  def show

    gon.image = Image.find(params[:id])
    @item = Item.find(params[:id])
    @image = Image.find(params[:id])
    @comments = @item.comments.includes(:user)
  end

  # 出品者以外がURLから直接的に編集、購入画面に進めないようにするため
  def ensure_correct_user
      @item = Item.find(1)
    if @item.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to(item_path(@item))
    end
  end


  def destroy
    @item = Item.find(params[:id])
    if @item.user_id == current_user.id && @item.destroy
      flash[:notice] = "削除しました"
    else
      flash[:notice] = "削除できませんでした"
      redirect_to(item_path(@item))
    end
  end


  def new
    @item = Item.new
    # newアクションで定義されたItemクラスのインスタンスに関連づけられたImageクラスのインスタンスが作成される。
    @item.images.new
  end

  # 以下全て、formatはjsonのみ
  # ----------------------------------------
   # 親カテゴリーが選択された後に動くアクション
   def category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    # routes.rbでjsonに限定したので、通常のアクションと同じ書き方でOK →通常はコントローラでrespond_to→respond_toとは、「リクエストがHTMLのレスポンスを求めているのか、それともJSONのレスポンスを求めているのか」を条件に条件分岐してくれるメソッド
    # jbuilderに渡す変数を作成する(@category_children)
    # ancestryを導入しているので、".children"メソッドで、選択されたものの子カテゴリーの配列を取得する。
    @category_children = Category.find_by(id: "#{params[:id]}", ancestry: nil).children
 end

 # 子カテゴリーが選択された後に動くアクション
 def category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    # routes.rbでjsonに限定したので、通常のアクションと同じ書き方でOK
    # jbuilderに渡す変数を作成する(@category_children)
    # findは通常条件にあった1つを取得するが、ancestryを導入しているので、".children"メソッドで、選択されたものの子カテゴリーの配列を取得することができる。
    @category_grandchildren = Category.find("#{params[:child_id]}").children
 end

# ユーザーが入力した金額を計算するアクション
 def price
  # デフォルトではparams[:price]は文字列として送られるため、.to_iをつけ整数型にする
  price = params[:price].to_i
  # 消費税の計算
  # roundをつけることで端数が生じた際に四捨五入できる
  @price_tax = (price * 0.1).round
  # 利益の計算
  @price_profit = price - @price_tax
 end

  def search
    @items = Item.where('name LIKE(?)', "%#{params[:keyword]}%")
    respond_to do |format|
      format.html
      format.json
    end
  end

  def detailed_search
    @items = @q.result(distinct: true)
    # @categories = Category.where(ancestry: nil)
  end

  


  def edit
  end 

    # ----------------------------------------
  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to root_path, notice: '出品完了しました'
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :brand, :status, :shipping_method, :region, :shopping_date, :price, :category_id, images_attributes: [:image]).merge(user_id: current_user.id)
  end

end