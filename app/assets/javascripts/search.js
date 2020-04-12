$(document).on('turbolinks:load', function(){
$(function() {
  function addItem(item) {
    let html = `
      <div class="search-result">
        <a href= "/items/${item.id}">${item.name}</a>
      </div>
    `;
    $(".item-search-result").append(html);
  }

  function addNoItem() {
    let html = `
      <div class="search-result">
        商品が見つかりません
      </div>
    `;
    $(".item-search-result").append(html);
  }

  $(".search").on("keyup", function() {
    var input = $(".search").val();
    console.log(input)
    $.ajax({
      type: 'GET',
      url: '/items/search',
      data: { keyword: input },
      dataType: 'json'
    })
      .done(function(items) {
        $(".item-search-result").empty();
        if (items.length !== 0) {
          items.forEach(function(item) {
            addItem(item);
          });
        } else if (input.length == 0) {
          return false;
        } else {
          addNoItem();
        }
      })
      .fail(function(){
        alert('検索に失敗しました');
      });
  });
});
})
