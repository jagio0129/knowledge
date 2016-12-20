# gem,bunlder,reuqireについて

## gemとは
rubyではサードパーティ製のライブラリをgemという形で配布している。[RubyGems](https://rubygems.org/)は(rubyに特化したapt-getと同じようなパッケージングシステム)ライブラリの作成や公開、インストールを助けるシステム。

## bundlerとは
```
Railsのアプリケーション開発を複数のPCで行なおうとした場合を考えてみます。
プログラムファイルはもちろんですが、全てのPCで対象のアプリケーションで使用している
Gemパッケージをインストールしておかなければなりません。
またGemパッケージのバージョンも揃える必要があります。
そこで使われるのがBundlerです。
BundlerはRailsアプリケーションに必要となるGemパッケージの種類やバージョンを管理し、
複数のPCで必要なGemパッケージをインストールする仕組みを提供してくれます。
```
[引用元](http://www.rubylife.jp/rails/ini/index2.html)

## requireとは
requireとは、ロードパスからファイルを探してきて自分のコードに組み込む仕組み。requireの他にもloadというものもある。reqireはLOAD_PATHが通ったところをロードする。


# 参考サイト
http://qiita.com/znz/items/5471e5826fde29fa9a80
