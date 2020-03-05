class ItemsController < ApplicationController
  def index
  end

  def update
  end

  def show
  end

  def new
    @item = Item.new
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
    # ----------------------------------------
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
    params.require(:item).permit(:name, :description, :category_id)
  end
end