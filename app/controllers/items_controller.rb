class ItemsController < ApplicationController
  before_action :authenticate_user!,except: [:index,:show,:search]
  before_action :ensure_correct_user,{only: [:edit,:buy,]} 
  before_action :set_parents, only: [:index, :show, :detailed_search]


  def index
    @items = Item.all
    @images = Image.all
    @item = Item.new
    parent_id = params[:parent_id]
    @children = Category.find_by(parent_id).children
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @item = Item.new
    # newアクションで定義されたItemクラスのインスタンスに関連づけられたImageクラスのインスタンスが作成される。
    @item.images.new
    gon.item = 0
  end

  def edit
    @item = Item.find(params[:id])
    gon.item = @item.images.ids.length
    gon.image = @item.images
    gon.ids = @item.id
    gon.id = @item.images.ids

    require 'base64'
    require 'aws-sdk'
    @item_images_binary_datas = []

    # base64エンコードで画像をバイナリデータに変化した値を配列に格納
    if Rails.env.production?
      client = Aws::S3::Client.new(
                             region: 'ap-northeast-1',
                             access_key_id: Rails.application.secrets.aws_AWS_ACCESS_KEY_ID,
                             secret_access_key: Rails.application.secrets.aws_AWS_SECRET_ACCESS_KEY,
                             )
      @item.images.each do |image|
        binary_data = client.get_object(bucket: 'freemarket-62-team-night-a', key: image.image.file.path).body.read
        @item_images_binary_datas << Base64.strict_encode64(binary_data)
      end
    else
      @item.images.each do |image|
        binary_data = File.read(image.image.file.file)
        @item_images_binary_datas << Base64.strict_encode64(binary_data)
      end
    end

    # 画像のinputタグの大きさの計算→プレビュー画像に応じてinputタグ縮小するため、その計算をここで実施
    # 配列に格納された画像のバイナリデータの数を算出
    @number = @item_images_binary_datas.size
    # バイナリデータの数に応じてMax値620の幅であるinputタグが小さくなっていく
    @size = 620 -((112+15) * @number)
  end 

  def update
    @item = Item.find(params[:id])
    if @item.update(update_item_params)
      redirect_to root_path, notice: '編集完了しました'
    else
      render :edit
    end
  end

  def category_select
    # カテゴリーが親要素の場合
    if @category.parent.nil?
      @category_parent        = @category.name
      @category_child         = " "
      @category_grandchildern = " "
      gon.category_parent = @category
      gon.select_parent   = @category.children
# カテゴリーが子要素の場合
    elsif @category.parent.parent.nil?
      @category_parent        = @category.parent.name
      @category_child         = @category.name
      @category_grandchildern = " "
      gon.category_parent = @category.parent
      gon.category_child  = @category
# カテゴリーが孫要素の場合
    else
      @category_parent        = @category.parent.parent.name
      @category_child         = @category.parent.name
      @category_grandchildern = @category.name
      gon.category_parent = @category.parent.parent
      gon.category_child  = @category.parent
      gon.category_grandchildern = @category
    end
  end

  def show
    gon.image = Image.find_by(item_id: params[:id])
    @item = Item.find(params[:id])
    @item_image = @item.images[0]
    @category = Category.find_by(id: "#{@item.category_id}")
    category_select
    @image = Image.find_by(item_id: params[:id])
    @comments = @item.comments.includes(:user)
  end

  # 出品者以外がURLから直接的に編集、購入画面に進めないようにするため
  def ensure_correct_user
      @item = Item.find(params[:id])
    if @item.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to(item_path(@item))
    end
  end


  def destroy
    @item = Item.find(params[:id])
    if @item.user_id == current_user.id && @item.destroy
      flash[:notice] = "削除しました"
      redirect_to root_path
    else
      flash[:notice] = "削除できませんでした"
      redirect_to(item_path(@item))
    end
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
    @categories = Category.where(ancestry: nil)
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

  def image_destroy
    iddata = params[:takeshi]
    iddata.each do |i|
      Image.find(i).destroy
      end
    # return iddata
    # binding.pry
    # iddata << params[:id].to_i
    # binding.pry
    # Image.find(id).destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :brand, :status, :shipping_method, :region, :shopping_date, :price, :category_id, images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def update_item_params
    params.require(:item).permit(:name, :description, :brand, :status, :shipping_method, :region, :shopping_date, :price, :category_id, images_attributes: [:image, :id]).merge(user_id: current_user.id)
  end

end