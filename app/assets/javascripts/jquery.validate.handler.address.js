$(function () {
  // メソッドの定義
  var methods = {
    valueNotEquals: function (value, element, arg) { 
      return arg !== value;
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
      "address[postal_code]":{
        required: true,
        postalCode: true
      },
      "address[prefecture_id]":{
        valueNotEquals: ""
      },
      "address[municipalitie]":{
        required: true
      },
      "address[street]":{
        required: true
      }
    },
    messages:{
      "address[postal_code]":{
        required: "郵便番号を入力してください",
        postalCode: "フォーマットが不適切です"
      },
      "address[prefecture_id]":{
        valueNotEquals: "都道府県を選択してください"
      },
      "address[municipalitie]":{
        required: "市区町村を入力してください"
      },
      "address[street]":{
        required: "番地を入力してください"
      }
    },
    errorClass: "invalid",
    errorElement: "p",
    validClass: "valid",

    errorPlacement: function (error, element) {
      if (element.attr("name") == "address[postal_code]") {
        error.insertAfter("#postal_code_error");
      }
      else if (element.attr("name") == "address[prefecture_id]") {
        error.insertAfter("#prefecture_id_error");
      }
      else if (element.attr("name") == "address[municipalitie]") {
          error.insertAfter("#municipalitie_error");
      }
      else {
        error.insertAfter(element);
      }
    }
  });
  $("#postal_code, #prefecture_id, #municipalitie, #street").blur(function () {
    $(this).valid();
  });
});