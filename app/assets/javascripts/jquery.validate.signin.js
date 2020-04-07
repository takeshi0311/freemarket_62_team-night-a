$(document).on('turbolinks:load', function(){
$(function () {
  // メソッドの定義
  var methods = {
    email: function (value, element) { // メールアドレスの正規表現
      return this.optional(element) || /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/i.test(value);
    },
    password: function (value, element) { // パスワードの正規表現
      return this.optional(element) || /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}$/i.test(value);
    },
    frigana: function (value, element) { // カタカナの正規表現
      return this.optional(element) || /^[ァ-ヴ]+$/.test(value);
    },
    valueNotEquals: function (value, element, arg) { // プルダウンリストが選択されているかの確認
      return arg !== value;
    },
    phone: function (value, element) { // 電話番号の正規表現
      return this.optional(element) || /^0\d{9,10}$/.test(value);
    },
  }
  // メソッドの追加
  $.each(methods, function (key) {
    $.validator.addMethod(key, this);
  });
  // バリデーションの実行
  $("#signup-form").validate({
    // ルール設定
    rules: {
      "user[nickname]": {
        required: true, // ニックネームの入力有無チェック
      },
      "user[email]": {
        required: true, // メールアドレスの入力有無チェック
        email: true // メールアドレスの正規表現チェック
      },
      "user[password]": {
        required: true, // パスワードの入力有無チェック
        password: true // メールアドレスの正規表現チェック
      },
      "user[password_confirmation]": {
        required: true, // 入力必須
        password: true, // 正規表現
        equalTo: "#password" // パスワードと確認用パスワードが一致しているかチェック
      },
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
      "user[birthday_year]": {
        valueNotEquals: "--"
      },
      "user[birthday_month]": {
        valueNotEquals: "--"
      },
      "user[birthday_day]": {
        valueNotEquals: "--"
      },
      "user[phone_number]": {
        required: true, // ニックネームの入力有無チェック
        phone: true // 電話番号の正規表現チェック
      },
    
    },
    // エラーメッセージの定義
    messages: {
      "user[nickname]": {
        required: "ニックネームを入力してください"
      },
      "user[email]": {
        required: "メールアドレスを入力してください",
        email: "フォーマットが不適切です"
      },
      "user[password]": {
        required: "パスワードを入力してください",
        password: "英字と数字両方を含むパスワードを入力してください"
      },
      "user[password_confirmation]": {
        required: "確認用パスワードを入力してください",
        password: "英字と数字両方を含むパスワードを入力してください",
        equalTo: "パスワードが一致していません"
      },
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
      "user[birthday_year]": {
        valueNotEquals: "生年月日を入力してください"
      },
      "user[birthday_month]": {
        valueNotEquals: "生年月日を入力してください"
      },
      "user[birthday_day]": {
        valueNotEquals: "生年月日を入力してください"
      },
      "user[phone_number]": {
        required: "電話番号を入力してください",
        phone: "フォーマットが不適切です"
      },
    },
    // グループ化してメッセージを一つだけ表示
    groups: {
      birthday: "user[birthday_year] user[birthday_month] user[birthday_day]"
    }, 
    
    errorClass: "invalid", // バリデーションNGの場合に追加するクラス名の指定
    errorElement: "p", // エラーメッセージの要素種類の指定
    validClass: "valid", // バリデーションOKの場合に追加するクラス名の指定
    errorPlacement: function (error, element) {
      if (element.attr("name") == "user[last_name]" || element.attr("name") == "user[family_name]") {
        error.insertAfter("#name_error"); // 指定した要素の後ろにエラーを表示
      }
      else if (element.attr("name") == "user[frigana_last_name]" || element.attr("name") == "user[frigana_family_name]") {
        error.insertAfter("#frigana_name_error");
      }

      else if (element.attr("name") == "user[birthday_year]" || element.attr("name") == "user[birthday_month]" || element.attr("name") == "user[birthday_day]") {
        $("#birth_month-error, #birth_day-error, #birth_year-error").remove();
        error.insertAfter("#birth_date_error");
      }
      
      
      else {
        error.insertAfter(element);
      }


      
    }
});
    $("#nickname, #email, #password, #password_confirmation, #family_name, #last_name, #frigana_family_name, #frigana_last_name, #phonenumber").blur(function () {
      $(this).valid();
    })
    });
});



