class CategoriesController < ApplicationController
  def index
    @parents = Category.where(ancestry: nil)
    @children = Category.where(ancestry: 1)
    @grand_children = Category.where(ancestry: "1/2")
  end
end
