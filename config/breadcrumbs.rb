crumb :root do
  link "FURIMA", root_path
end

# マイページ
crumb :mypage do
  link "マイページ", mypage_users_path
end

crumb :item_name do |item_name|
  item_name = Item.find_by(id: params[:id])
  link item_name.name
  parent :root
end

