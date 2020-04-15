$(window).on('turbolinks:load', function(){
$(function(){
  // カテゴリーセレクトボックスのオプションを作成（関数定義）
  function appendOption(category){
    let html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成（選択肢の表示）
  function appendChidrenBox(insertHTML){
    let childSelectHtml = '';
    childSelectHtml = `<div class="sell__detail--selecttop" id= "children_wrapper">
                          <select class="sell__detail--box" id="child_category" name= "item[category_id]">
                          <option value>選択してください</option>
                            ${insertHTML}
                          </select>
                        </div>`;
    $('#parent_category').after(childSelectHtml);
  }
  // 孫カテゴリーの表示作成（選択肢の表示）
  function appendGrandchidrenBox(insertHTML){
    let grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class="sell__detail--selecttop" id= "grandchildren_wrapper">
                              <select class="sell__detail--box" id="grandchild_category" name= "item[category_id]">
                              <option value="">選択してください</option>
                                ${insertHTML}
                              </select>
                            </div>`;
    $('#child_category').after(grandchildSelectHtml);
  }
  // 親カテゴリー選択後のイベント（イベント発火後、子要素のセレクトボックスが出現）
  $('#parent_category').on('change', function(){
    $('#child_category').remove();
    $('#grandchild_category').remove();
    let parent_category = $('#parent_category option:selected').val(); //選択された親カテゴリーの名前を取得
    if (parent_category != ""){ //親カテゴリーが初期値でないことを確認
      $.ajax({
        // リクエストを送信する先のURL
        url: '/items/category_children',
        // HTTP通信の種類を記述する
        type: 'GET',
        // サーバに送信する値
        data: { id: parent_category },
        // サーバから返されるデータの型
        dataType: 'json'
      })
      // doneはAjax通信が成功したとき,failはAjax通信が失敗したとき
      // childrenには、フォーマットがjsonの場合は、作成した@category_childrenをjson形式にして返す記述
      .done(function(children){
        $('#child_category').remove(); //親が変更された時、子以下を削除する
        $('#grandchild_category').remove();
        let insertHTML = '';
        // forEach文によって配列の子カテゴリーを一つ一つ展開し、HTML文に変換していく
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#child_category').remove(); //親カテゴリーが初期値になった時、子以下を削除する
      $('#grandchild_category').remove();
    }
  });
  // 子カテゴリー選択後のイベント（イベント発火後、孫要素のセレクトボックスが出現）
  $(document).on('change', '#child_category', function(){
    let childId = $('#child_category option:selected').val(); //選択された子カテゴリーのvalue値を取得
    console.log(childId)
    if (childId != ""){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        // リクエストを送信する先のURL
        url: '/items/category_grandchildren',
        // HTTP通信の種類を記述する
        type: 'GET',
        // サーバに送信する値
        data: { child_id: childId },
        // サーバから返されるデータの型
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchild_category').remove(); //子が変更された時、孫以下を削除するする
          let insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchild_category').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
    }
  });
});
})