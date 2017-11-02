**[RailsでPOSTすると422エラー](http://sps.co.jp/?p=60)**
> CSRF 対策のため、GET メソッド以外は認証用のトークン文字列を必要とします。

**[CSRFの対応について、rails使いが知っておくべきこと](http://blog.willnet.in/entry/20080509/1210338845)**
> railsは、get以外の動詞のリンクに、authenticity_tokenというパラメータを自動的に付け加えます。get以外の動詞の各アクションでparams[:authenticity_token]とsession[:csrf_id]を比較して、同値であればOKとしているようです。*1同値でなければActionController::InvalidAuthenticityTokenという例外がでます


## 参考
- [Redmine 2.5.2 の REST API で 「422 Unprocessable Entity」 の原因が日付フォーマットだった話。](http://category7.blog.fc2.com/blog-entry-105.html)
- [rails で post リクエストすると 422 エラーが返る](http://sps.co.jp/?p=60)
- [CSRFの対応について、rails使いが知っておくべきこと](http://blog.willnet.in/entry/20080509/1210338845)
- [RailsでajaxでPOSTしたときにセッションクッキーをセットしてもらう](http://qiita.com/lirispp/items/333859c456c3480ead26)
