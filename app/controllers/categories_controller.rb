class CategoriesController < ApplicationController
  before_action :set_parents

  def index
    @parents = Category.where(ancestry: nil)
    @children = Category.where(ancestry: 1)
    @grand_children = Category.where(ancestry: "1/2")
  end

  def new
    parent_id = params[:parent_id]
    @children = Category.find_by(parent_id).children
    respond_to do |format|
      format.html
      format.json
    end
  end
end
