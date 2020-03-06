$(function(){
  $('.sell__price--default').on('keyup', function(){
    let price = $(this).val();
    if (price >= 300 && price <= 9999999){
      $.ajax({
        // リクエストを送信する先のURL
        url: '/items/price',
        // HTTP通信の種類を記述する
        type: 'GET',
        // サーバに送信する値
        data: { price: price },
        // サーバから返されるデータの型
        dataType: 'json'
      })
      .done(function(price){
         let pricetaxHtml = `<div class="sell__price--border">¥${price.tax}</div>`;
         let priceprofitHtml = `<div class="sell__price--border">¥${price.profit}</div>`;
        $('.sell__price--border:eq(0)').replaceWith(pricetaxHtml)
        $('.sell__price--border:eq(1)').replaceWith(priceprofitHtml)
      })
      .fail(function(){
        alert('計算に失敗しました');
      })
    }else {
      let DefaultHtml = `<div class="sell__price--border">-</div>`;
      $('.sell__price--border:eq(0)').replaceWith(DefaultHtml)
      $('.sell__price--border:eq(1)').replaceWith(DefaultHtml)
    }
  });
});