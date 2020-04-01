$(window).on('turbolinks:load', function(){
  $(function(){

    // プレビューされている画像にidを振る
    var array = gon.id
    $.each(array, function(index, value) {
      $('.upper-box img').eq(index).attr('id', value);
    })

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
      // prev()：特定のHTML要素を対象にしてその直前に配置されている要素を取得する
      var prevContent = $('.label-content').prev();
      // replace(/[^0-9]/g, '')：第1引数に置換前の対象文字列を指定、第2引数に置換後の新規文字列を設定→→今回は「px」を取り除く処理をしている
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      // css("プロパティ", "値")：cssの直書き・変更
      $('.label-content').css('width', labelWidth);
    }

    // 下記の条件より、出品機能のJQuery
    if (gon.item == 0) {
    // プレビューの追加
    $(document).on('change', '.hidden-field', function() {
      setLabel();
      //hidden-fieldのidの数値のみ取得
      // attr():HTML要素の属性を取得したり設定することができるメソッド
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //labelボックスのidとforを更新
      $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
      //選択したfileのオブジェクトを取得
      var file = this.files[0];
      console.log(file)
      var reader = new FileReader();
      //readAsDataURLで指定したFileオブジェクトを読み込む
      reader.readAsDataURL(file);
      //読み込み時に発火するイベント
      reader.onload = function() {
        // resuleプロパティ：fileの読み込み成功後、データの中身を取得するには、resultプロパティを使用。
        var image = this.result;
        //プレビューが元々なかった場合はhtmlを追加
        if ($(`#preview-box__${id}`).length == 0) {
          var count = $('.preview-box').length;
          var html = buildHTML(id);
          //ラベルの直前のプレビュー群にプレビューを追加
          // prev()：特定のHTML要素を対象にしてその直前に配置されている要素を取得する
          var prevContent = $('.label-content').prev();
          // append():指定した子要素の最後にテキスト文字やHTML要素を追加することができるメソッド
          $(prevContent).append(html);
        }
        //イメージを追加
        $(`#preview-box__${id} img`).attr('src', `${image}`);
        var count = $('.preview-box').length;
        //プレビューが5個あったらラベルを隠す 
        if (count == 5) { 
          // hide():非表示にしたいHTML要素を画面から非表示にできるメソッド
          $('.label-content').hide();
        }

        //ラベルのwidth操作
        setLabel();
        //ラベルのidとforの値を変更
        if(count < 5){
          //プレビューの数でラベルのオプションを更新する
          // attrメソッドは、下記の書き方にすることで、id属性の値とfor属性の値を上書きすることができる
          $('.label-box').attr({id: `label-box--${count}`,for: `item_images_attributes_${count}_image`});
        }
      }
    });
  }else{
    //下記は編集機能のJQuery
    var id = gon.item
    $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
    $(document).on('change', '.hidden-field', function() {
      setLabel();
      //hidden-fieldのidの数値のみ取得
      // attr():HTML要素の属性を取得したり設定することができるメソッド
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //labelボックスのidとforを更新
      $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
      //選択したfileのオブジェクトを取得
      var file = this.files[0];
      var reader = new FileReader();
      //readAsDataURLで指定したFileオブジェクトを読み込む
      reader.readAsDataURL(file);
      // console.log(reader.readAsDataURL(file))
      //読み込み時に発火するイベント
      reader.onload = function() {
        // resuleプロパティ：fileの読み込み成功後、データの中身を取得するには、resultプロパティを使用。
        var image = this.result;
        //プレビューが元々なかった場合はhtmlを追加
        if ($(`#preview-box__${id}`).length == 0) {
          var count = $('.preview-box').length;
          var html = buildHTML(id);
          //ラベルの直前のプレビュー群にプレビューを追加
          // prev()：特定のHTML要素を対象にしてその直前に配置されている要素を取得する
          var prevContent = $('.label-content').prev();
          // append():指定した子要素の最後にテキスト文字やHTML要素を追加することができるメソッド
          $(prevContent).append(html);
        }
        //イメージを追加
        $(`#preview-box__${id} img`).attr('src', `${image}`);
        var count = $('.preview-box').length;
        //プレビューが5個あったらラベルを隠す 
        if (count == 5) { 
          // hide():非表示にしたいHTML要素を画面から非表示にできるメソッド
          $('.label-content').hide();
        }

        //ラベルのwidth操作
        setLabel();
        //ラベルのidとforの値を変更
        if(count < 5){
          //プレビューの数でラベルのオプションを更新する
          // attrメソッドは、下記の書き方にすることで、id属性の値とfor属性の値を上書きすることができる
          $('.label-box').attr({id: `label-box--${count}`,for: `item_images_attributes_${count}_image`});
        }
      }
    });
  }

    // 画像の削除
    $(document).on('click', '.delete-box', function() {
      var count = $('.preview-box').length;
      setLabel(count);
      //item_images_attributes_${id}_image から${id}に入った数字のみを抽出
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      var iddata = $(`#preview-box__${id} img`).attr("id");
      $.ajax({
        url: "/items/image_destroy",
        type: "GET",
        data: { id: iddata },
        dataType: 'json',
        success: function(data){
          //成功時の処理
        },
        error: function(data){
          //失敗時の処理
        }
      });
      //取得したidに該当するプレビューを削除
      $(`#preview-box__${id}`).remove();
      // 削除したプレビューのinputを空にする
      $(`#item_images_attributes_${id}_image`).val('');
      // console.log("new")
      //フォームの中身を削除 
      // $(`#item_images_attributes_${id}_image`).val("");

      //削除時のラベル操作
      var count = $('.preview-box').length;
      //5個めが消されたらラベルを表示
      if (count == 4) {
        // show()メソッド：各要素のうち、非表示状態にあるものを表示します。
        // 要素の「非表示状態」は、hide()メソッドを使ったものであれ、スタイル属性で display:none を用いたものであれ、同様に表示状態にする。
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