function changeimage(myPicURL){
  document.images["BigImage"].src = myPicURL;
}
// ChangeImage関数は、第1引数に「差し替えたい画像(＝img要素)に付加したID名」を指定することで差し替え処理を実行してくれる関数です。
// document.imagesでhamlの要素を取得
