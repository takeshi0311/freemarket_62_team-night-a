$(function () {
  // メソッドの定義
  var methods = {
    valueNotEquals: function (value, element, arg) { // プルダウンリストが選択されているかの確認
      return arg !== value;
    },
  }
  // メソッドの追加
  $.each(methods, function (key) {
    $.validator.addMethod(key, this);
  });
  // バリデーションの実行
  $("#sell__form").validate({
    // ルール設定
    rules: {
      "item[images_attributes][0][image]": {
        required: true
      },
      "item[name]": {
        required: true,
        maxlength: 40
      },
      "item[description]": {
        required: true,
        maxlength: 1000
      },
      "item[category_id]": {
        valueNotEquals: ""
      },
      "item[status]": {
        valueNotEquals: ""
      },
      "item[shipping_method]": {
        valueNotEquals: ""
      },
      "item[shopping_date]": {
        valueNotEquals: ""
      },
      "item[price]": {
        required: true,
        range: [300, 9999999]
      }
    },
    // エラーメッセージの定義
    messages: {
      "item[images_attributes][0][image]": {
        required: '画像がありません'
      },
      "item[name]": {
        required: '入力してください',
        maxlength: '40文字以下で入力してください'
      },
      "item[description]": {
        required: '入力してください',
        maxlength: '1000文字以下で入力してください'
      },
      "item[category_id]": {
        valueNotEquals: "選択してください"
      },
      "item[status]": {
        valueNotEquals: "選択してください"
      },
      "item[shipping_method]": {
        valueNotEquals: "選択してください"
      },
      "item[shopping_date]":{
        valueNotEquals: "選択してください"
      },
      "item[price]": {
        required: '300以上9999999以下で入力してください',
        range: '300以上9999999以下で入力してください'
      }
    },
    errorClass: "invalid",
    errorElement: "p",
    validClass: "valid",
    // エラーメッセージ表示位置のカスタム設定
    errorPlacement: function (error, element) {
      if (element.attr("name") == "item[price]") {
        error.insertAfter(".sell__price--group");
      } else if(element.attr("name") == "item[images_attributes][0][image]"){
        error.insertAfter(".post__drop__box__container");
      }else {
        error.insertAfter(element);
      }
    }
  });
  // 選択欄をフォーカスアウトしたときにバリデーションを実行(ウィザードページ毎)
  $("#item_images_attributes_0_image, #item_name, #item_description, #parent_category, #child_category, #grandchild_category, #item_status, #item_shipping_method, #item_shopping_date, #item_price").blur(function () {
    $(this).valid();
  });
});