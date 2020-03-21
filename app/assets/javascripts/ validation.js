// $(function()
// {
//   // エラーメッセージは共通なので、ここで関数として定義
//   function errormessage(){
//         let error;// エラー用の変数を定義
//         let value = $(this).val();//.sell__name--textの要素のvalue属性を定義
//         if(value == "")//.sell__name--textの要素のvalue属性の値が空な場合
//         {
//           error = true;
//         }
//         else if(!value.match(/[^\s\t]/))//match(/[^\s\t]/)→空白とタブ文字以外の文字とマッチ
//         {
//           error = true;
//         }

//         if(error)
//         {
//           //エラー時の処理

//           //エラーで、エラーメッセージがなかったら
//         if($(this).nextAll('div.error-info').length == 0)//nextAll:同階層の次以降の要素をすべてチェックできるわけです。
//         {
//           //メッセージを後ろに追加
//           $(this).after('<div class = "error-info">入力してください</div>');
//           //エラーメッセージのスタイル
//           $('div.error-info').css({"color":"red", "margin-top":"16px", "font-size":"14px", "line-height":"1.4em"});
//           $(this).css("border", "1px solid red");
//         }
//         }
//         else
//         { 
//           //エラーじゃないのにメッセージがあったら
//           if($(this).nextAll('div.error-info').length)
//           {
//             //消す
//             $(this).nextAll('div.error-info').remove();
//             $(this).css("border", "");
//           }
//         }
//     }
//   //各クラスにバリデーションをかける
//   $('.sell__name--text').on('blur', errormessage);
//   $('.sell__explain--text').on('blur', errormessage);
//   });