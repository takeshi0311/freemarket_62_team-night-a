// // //初回読み込み、リロード、ページ切り替えで動く。
// $(document).on('turbolinks:load', ()=> {
//   // 画像用のinputを生成する関数
//   const buildFileField = (index)=> {
//     // const html = `<div data-index="${index}" class="js-file_group">
//     //                 <input class="js-file" type="file"
//     //                 multiple="multiple"
//     //                 name="item[images_attributes][${index}][image]"
//     //                 id="sell__image--upload--file">
//     //                 <br>
//     //               </div>`;
//     const html = `<input class="hidden-field" id="item_images_attributes_${index}_image" name="item[images_attributes][${index}][image]" type="file"></input>`;
//     return html;
//   }

//   // プレビュー用のimgタグを生成する関数
//   const buildImg = (index, url)=> {
//     const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
//     return html;
//   }

//   // file_fieldのnameに動的なindexをつける為の配列
//   let fileIndex = [1,2,3,4,5,6,7,8,9,10];

//   $('.js-file').on('change', function(e) {
//     // fileIndexの先頭の数字を使ってinputを作る
//     $('.sell__image--class').append(buildFileField(fileIndex[0]));
//     // shift()メソッド:配列の先頭から要素を削除する
//     fileIndex.shift();
//     // 末尾の数に1足した数を追加する
//     // push()メソッド：配列データの末尾に任意の要素を追加する
//     fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
//   });

//   $('.sell__image--class').on('click', '.js-remove', function() {
//     $(this).parent().remove();
//     // 画像入力欄が0個にならないようにしておく
//     if ($('.js-file').length == 0) $('.sell__image--class').append(buildFileField(fileIndex[0]));
//   });
//   // ---ここから下は、画像投稿時のプレビュー---------------------------------------------------------------
//   $('.sell__image--third').on('change', ".js-file", function(e) {
//     // .js-fileの親要素である.js-file_groupのdata-indexの値を取得→parent()メソッドで要素の親要素を取得
//     const targetIndex = $(this).parent().data('index');
//     // targetメソッド：イベントが発生したDOM要素を取得
//     // files[0]：複数選択された場合も先頭の1つだけを取得
//     const file = e.target.files[0];
//     // ファイルのブラウザ上でのURLを取得する
//     const blobUrl = window.URL.createObjectURL(file);
//     // 該当indexを持つimgタグがあれば取得して変数imgに入れる(画像変更の処理)
//     if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
//       // setAttribute:指定した要素上に新しい属性を追加、また既存の値を変更
//       // attr:HTML要素の属性を取得したり設定することができるメソッド
//       img.setAttribute('image', blobUrl);
//     } else {  // 新規画像追加の処理
//       $('#previews').append(buildImg(targetIndex, blobUrl));
//       // fileIndexの先頭の数字を使ってinputを作る
//       $('.sell__image--class').append(buildFileField(fileIndex[0]));
//       fileIndex.shift();
//       // 末尾の数に1足した数を追加する
//       fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
//     }
//   });
// });
$(document).on('turbolinks:load', function(){
  $(function(){

    //プレビューのhtmlを定義
    function buildHTML(count) {
      var html = `<div class="preview-box" id="preview-box__${count}">
                    <div class="upper-box">
                      <img src="" alt="preview">
                    </div>
                    <div class="lower-box">
                      <div class="update-box">
                        <label class="edit_btn">編集</label>
                      </div>
                      <div class="delete-box" id="delete_btn_${count}">
                        <span>削除</span>
                      </div>
                    </div>
                  </div>`
      return html;
    }

    // ラベルのwidth操作
    function setLabel() {
      //プレビューボックスのwidthを取得し、maxから引くことでラベルのwidthを決定
      var prevContent = $('.label-content').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content').css('width', labelWidth);
    }

    // プレビューの追加
    $(document).on('change', '.hidden-field', function() {
      setLabel();
      //hidden-fieldのidの数値のみ取得
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //labelボックスのidとforを更新
      $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
      //選択したfileのオブジェクトを取得
      var file = this.files[0];
      var reader = new FileReader();
      //readAsDataURLで指定したFileオブジェクトを読み込む
      reader.readAsDataURL(file);
      //読み込み時に発火するイベント
      reader.onload = function() {
        var image = this.result;
        //プレビューが元々なかった場合はhtmlを追加
        if ($(`#preview-box__${id}`).length == 0) {
          var count = $('.preview-box').length;
          var html = buildHTML(id);
          //ラベルの直前のプレビュー群にプレビューを追加
          var prevContent = $('.label-content').prev();
          $(prevContent).append(html);
        }
        //イメージを追加
        $(`#preview-box__${id} img`).attr('src', `${image}`);
        var count = $('.preview-box').length;
        //プレビューが5個あったらラベルを隠す 
        if (count == 5) { 
          $('.label-content').hide();
        }

        //ラベルのwidth操作
        setLabel();
        //ラベルのidとforの値を変更
        if(count < 5){
          //プレビューの数でラベルのオプションを更新する
          $('.label-box').attr({id: `label-box--${count}`,for: `item_images_attributes_${count}_image`});
        }
      }
    });

    // 画像の削除
    $(document).on('click', '.delete-box', function() {
      var count = $('.preview-box').length;
      setLabel(count);
      //item_images_attributes_${id}_image から${id}に入った数字のみを抽出
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //取得したidに該当するプレビューを削除
      $(`#preview-box__${id}`).remove();
      console.log("new")
      //フォームの中身を削除 
      $(`#item_images_attributes_${id}_image`).val("");

      //削除時のラベル操作
      var count = $('.preview-box').length;
      //5個めが消されたらラベルを表示
      if (count == 4) {
        $('.label-content').show();
      }
      setLabel(count);

      if(id < 5){
        //削除された際に、空っぽになったfile_fieldをもう一度入力可能にする
        $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
      }
    });
  });
})