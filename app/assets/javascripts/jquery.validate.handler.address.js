$(function () {
  // メソッドの定義
  var methods = {
    valueNotEquals: function (value, element, arg) { 
      return arg !== value;
    },
    frigana: function (value, element) { // カタカナの正規表現
      return this.optional(element) || /^[ァ-ヴ]+$/.test(value);
    },
    postalCode: function (value, element) { // 郵便番号の正規表現
      return this.optional(element) || /^\d{3}[-]\d{4}$/.test(value);
    }
  }

  $.each(methods, function (key){
    $.validator.addMethod(key,this);
  });

  $("#address-form").validate({
    rules:{
      "user[family_name]": {
        required: true // 姓の入力有無チェック
      },
      "user[last_name]": {
        required: true // 名の入力有無チェック
      },
      "user[frigana_family_name]": {
        required: true, // 姓(カナ)の入力有無チェック
        frigana: true // カナの正規表現チェック
      },
      "user[frigana_last_name]": {
        required: true, // 名(カナ)の入力有無チェック
        frigana: true // カナの正規表現チェック
      },
      "user[address_attributes][postal_code]":{
        required: true,
        postalCode: true
      },
      "user[address_attributes][prefecture_id]":{
        valueNotEquals: ""
      },
      "user[address_attributes][municipalitie]":{
        required: true
      },
      "user[address_attributes][street]":{
        required: true
      }
    },
    messages:{
      "user[family_name]": {
        required: "姓を入力してください"
      },
      "user[last_name]": {
        required: "名を入力してください"
      },
      "user[frigana_family_name]": {
        required: "姓(カナ)を入力してください",
        frigana: "フォーマットが不適切です"
      },
      "user[frigana_last_name]": {
        required: "名(カナ)を入力してください",
        frigana: "フォーマットが不適切です"
      },
      "user[address_attributes][postal_code]":{
        required: "郵便番号を入力してください",
        postalCode: "フォーマットが不適切です"
      },
      "user[address_attributes][prefecture_id]":{
        valueNotEquals: "都道府県を選択してください"
      },
      "user[address_attributes][municipalitie]":{
        required: "市区町村を入力してください"
      },
      "user[address_attributes][street]":{
        required: "番地を入力してください"
      }
    },
    errorClass: "invalid",
    errorElement: "p",
    validClass: "valid",

    errorPlacement: function (error, element) {
      if (element.attr("name") == "user[last_name]" || element.attr("name") == "user[family_name]") {
        error.insertAfter("#name_error"); // 指定した要素の後ろにエラーを表示
      }
      else if (element.attr("name") == "user[frigana_last_name]" || element.attr("name") == "user[frigana_family_name]") {
        error.insertAfter("#frigana_name_error");
      }
      else if (element.attr("name") == "user[address_attributes][postal_code]") {
        error.insertAfter("#postal_code_error");
      }
      else if (element.attr("name") == "user[address_attributes][prefecture_id]") {
        error.insertAfter("#prefecture_id_error");
      }
      else if (element.attr("name") == "user[address_attributes][municipalitie]") {
          error.insertAfter("#municipalitie_error");
      }
      else {
        error.insertAfter(element);
      }
    }
  });
  $("#family_name, #last_name, #frigana_family_name, #frigana_last_name,#postal_code, #prefecture_id, #municipalitie, #street").blur(function () {
    $(this).valid();
  });
});