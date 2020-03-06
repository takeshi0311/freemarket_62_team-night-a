class ItemsController < ApplicationController
  def index
    @image = Image.all
    @item = Item.all
  end

  def update
  end

  def show
  end

  def edit
    @image = Image.find(1)
    @item = Item.find(1)
  end 
end
