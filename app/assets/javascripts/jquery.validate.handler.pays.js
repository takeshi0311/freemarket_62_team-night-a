$(function () {
  // メソッドの定義
  var methods = {
    valueNotEquals: function (value, element, arg) { // プルダウンリストが選択されているかの確認
      return arg !== value;
    },
    cardNumber: function (value, element) { // クレジットカード番号の正規表現
      return this.optional(element) || /^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6011[0-9]{12}|3(?:0[0-5]|[68][0-9])[0-9]{11}|3[47]{13}|(?:2131|1800|35[0-9]{3})[0-9]{11})$/.test(value);
    },
    cvc: function (value, element) { // セキュリティコードの正規表現
      return this.optional(element) || /^\d{3,4}$/.test(value);
    },
  }
  // メソッドの追加
  $.each(methods, function (key) {
    $.validator.addMethod(key, this);
  });
  // バリデーションの実行
  $("#charge-form").validate({
    // ルール設定
    rules: {
      card_number: {
        required: true,
        cardNumber: true
      },
      exp_month: {
        valueNotEquals: ""
      },
      exp_year: {
        valueNotEquals: ""
      },
      cvc: {
        required: true,
        cvc: true
      }
    },
    // エラーメッセージの定義
    messages: {
      card_number: {
        required: "クレジットカード番号を入力してください",
        cardNumber: "有効なクレジットカード番号を入力してください"
      },
      exp_month: {
        valueNotEquals: "有効期限を選択してください"
      },
      exp_year: {
        valueNotEquals: "有効期限を選択してください"
      },
      cvc: {
        required: "セキュリティコードを入力してください",
        cvc: "4桁もしくは3桁の番号を入力してください"
      }
    },
    groups: { //グループ化
      exp_date: "exp_month exp_year"
    },
    errorClass: "invalid",
    errorElement: "p",
    validClass: "valid",
    // エラーメッセージ表示位置のカスタム設定
    errorPlacement: function (error, element) {
      if (element.attr("name") == "card_number") {
        error.insertAfter("#card_number_error");
      }
      else if(element.attr("name") == "exp_month" || element.attr("name") == "exp_year") {
        error.insertAfter("#exp_date_error");
      }
      else {
        error.insertAfter(element);
      }
    }
  });
  $("#card_number,#exp_month, #exp_year,#cvc").blur(function () {
    $(this).valid();
  });
});