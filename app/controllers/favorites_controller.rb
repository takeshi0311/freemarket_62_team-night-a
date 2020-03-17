class FavoritesController < ApplicationController

  def create
    @Favorite = current_user.favorite.create(item_id: params[:item_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @Favorite = Favorite.find_by(item_id: params[:item_id], user_id: current_user.id)
    @Favorite.destroy
    redirect_back(fallback_location: root_path)
  end

end