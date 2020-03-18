class FavoritesController < ApplicationController

  def create
    @Favorite = current_user.favorite.create(item_id: params[:item_id])
    if @Favorite.save!
      flash[:notice] = "お気に入りに追加しました"
      redirect_back(fallback_location: root_path)
    else 
      flash[:notice] = "お気に入りに追加できませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @Favorite = Favorite.find_by(item_id: params[:item_id], user_id: current_user.id)
    if @Favorite.destroy!
      flash[:notice] = "お気に入りを解除しました"
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "お気に入りを解除できませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

end