# Cookie
- Webサイトの提供者が、ユーザのPCに一時的にデータを保存する仕組みのこと。
  - 例えば、Cookieにログイン情報を暗号化して保存しておくことに酔って、Webサービスにログインしたままにする機能や、Cookieに時間のかかる情報をキャッシュしておくことによって、アクセス時間を短くすることができる。
- Cookie情報はHTTPレスポンスヘッダを利用して送信される。この情報は「名前=値」の形で表される。

![image](https://camo.qiitausercontent.com/37709718d3a395cf26080d79229353e21e16baa6/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f36323236342f31306231343530652d353765392d303665352d333464342d6334336363383433323665382e706e67)

- webアプリケーション側では、リクエストヘッダにCookieを調べることで、アクセスしてきた相手がどのような相手なのかを知ることができる。
- Cookieは、さーばアクセスするたびに自動送信される。
- Cookieを受け取ったあとでも、Cookieを受け取ったサーバとは異なるWebサーバに対してはCookieを送らない。(意図しない情報が他のwebサーバに送られるのを防ぐ)

## Cookieの仕組み
1. サーバが'Set-Cookie'という名前のフィールドをHTTPヘッダに乗せてレスポンスを返す。Cookieとしてクライアントに保存して欲しい情報をこの'Set-Cookie'フィールドの値として設定する。

1. レスポンスを受け取ったクライアントはCookieをブラウザに保存する。そして、それ以降のリクエストには受け取ったCookieをそのままリクエストするようになる。
  - Cookieを載せてリクエストするURLの範囲は'Set-Cookie'の属性値で指定され、その値に従う。
  - Cookieには有効期限があり、有効期限が切れたCookieは消滅し、リクエストには乗らない。

![image](https://camo.qiitausercontent.com/2726da18882997a4e6af458882f09ec917bb7de4/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f323831332f36663132306563322d396134342d363961302d313530362d3162323838353763346639382e706e67)

## Cookieのためのヘッダフィールド
ヘッダフィールド名|説明|ヘッダ種別
---|---|---
Set-Cookie|状態管理開始のためのCookie情報|レスポンス
Cookie|サーバから受け取ったCookie情報|リクエスト

## Set-Cookieヘッダフィールド
属性|説明
---|---
NAME=VALUE|Cookieにつける名前とその値(必須)
Expires=DATE|Cookieの有効期限(デフォルトはブラウザを閉じるまで)
Max-Age=DATE|Cookieの有効期限を秒数で指定する。例えばMax-Age=100であれば100秒後に消滅する
Path=PATH|Cookieの適用対象となるサーバ上のパス(デフォルトはドキュメントと同じパス)
Domain=DOMAIN|Cookieの適用対象となるドメイン名(デフォルトはCookieを生成したサーバのドメイン名)
Secure|HTTPSで通信している場合にのみCookieを送信するオプション
HttpOnly|CookieをjavaScriptからアクセス出来ないようにする制限オプション

## セッション管理
セッションとは、一連のインタラクティブな操作のこと。例えばECサイトには商品を探し、カートに入れ、購入するという一連の流れがある。このように同一利用者からのアクセスを関連性のある一連のアクセスとして扱いたい場合、Cookieを使ってセッション管理が行われる。

1. クライアントはWebサイトにログインする。この時、ユーザIDとパスワードをサーバに送信する。
2. サーバはセッションIDを生成し、Cookieに乗せて返す
  - 例：Set-Cookie：hogehoge
  - なりすましを防ぐために、セッションIDは特定しにくい値にする必要がある。
3. 以降、クライアントはCookieにセッションIDを載せてリクエストすることでセッションの維持ができるようになる。

## 参考
- [Cookieとセッション管理](http://qiita.com/mogulla3/items/189c99c87a0fc827520e)
- [Cookieとセッションをちゃんと理解する](http://qiita.com/hththt/items/07136ad74127999df271)