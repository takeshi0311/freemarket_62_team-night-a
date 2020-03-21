class ItemsController < ApplicationController
  def index
    @image = Image.all
    @item = Item.all
  end

  def update
  end

  def show
  end

  def search
    @items = Item.where('name LIKE(?)', "%#{params[:keyword]}%")
    respond_to do |format|
      format.html
      format.json
    end
  end


  def edit
    gon.image = Image.find(1)
    @image = Image.find(1)
    @item = Item.find(1)
  end 
end
