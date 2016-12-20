# Rails バッチ処理について

## バッチ処理とは

バッチ処理とは**一定量の(あるいは一定期間の)データを集め、一括処理するための処理方法**

## 方法

1. runnerコマンドでバッチ処理
1. gem whereによるスケジューリング

### 1\. Rails runner

railsの環境を読み込んだ上で任意のrubyコードが実行できる。
Active Recordも使えるのでbatch処理のときに使える。


### 使用例

#### ネームスペースの設定
ファイルを指定して実行もできるが、名前空間を設定する。

```rb
[config/application.rb]

config.autoload_paths += %W(#{config.root}/lib)
```

#### 実行スクリプトを作る
lib/tasks以下にスクリプトを置く

```rb
[test.rb]

class Tasks:Test
    def self.execute
        puts 'test'
    end
end
```

### スクリプトの実行

```
$ rails runnner Tasks::Test.execute
```

## 参考サイト
- [railsのバッチの共通処理について考えてみた - Qiita](https://www.google.co.jp/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&uact=8&ved=0ahUKEwiVlpiq5_zPAhVBOrwKHQeEBEkQFggmMAE&url=http%3A%2F%2Fqiita.com%2FkoheiSG%2Fitems%2F4aec6207f88ec45f1128&usg=AFQjCNH6ZNZLr0QFm1znXWQQcOeU6GKzPg&sig2=KS6H2K0Gv2eTRgq9zSfnNA)
- [rails runnerの使い方](http://qiita.com/1234krerok/items/245f5247245a2a28b2e4)
