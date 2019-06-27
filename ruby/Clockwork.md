---
title: CloclWork
tags: ["Ruby", "gem"]
excerpt: ローカルマシンで定期的にスクリプトを動かしたいと気に使える。cronのようなもの。
date: 2018-12-31
---

# Clockwork

ローカルマシンで定期的にスクリプトを動かしたいと気に使える。cronのようなもの。

## **Install**

gemなので`gem install clockwork`で導入。

## **メソッド**

メソッド                                                      | 概要
--------------------------------------------------------- | -------------------------------------------------------------
every                                                     | 定期実行するジョブを定義する
handler                                                   | ジョブ実行時に呼び出される処理を定義するメソッド
Numeric#seconds,Numeric#minutes,Numeric#hour,Numeric#day, | 時間指定
configure                                                 | Clockworkの初期状態に呼び出され、Clockworkのマルチスレッド/ロギング/タイムゾーンに関する設定を定義する

## **サンプルソース**

```ruby
require 'clockwork'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(10.seconds, 'frequent.job')
  every(3.minutes, 'less.frequent.job')
  every(1.hour, 'hourly.job')

  every(1.day, 'midnight.job', :at => '00:00')
end
```

## 基本

- handlerにジョブ実行時の処理を定義する。
- everyでジョブを定義する。
- everyでジョブの実行タイミングを指定する際にNumeric#secounds, Numeric#minutes, Numeric#hour, Numeric#dayを使う。
- moduke Clockworkはhandler,everyを呼びやすくするためのもので、特別な事情が泣けrばそのままで良い。

## **実行**

### **フォアグランド実行**

`clockwork clock.rb`<br>
puts等を記述していればその処理も表示される。Ctrl+Cで終了。

### **バックグラウンド実行**

フォアグランドのままではターミナルを閉じると定期実行も終了してしまうので、 `clockworkd -c hoge.rb start --log`

clockworkdコマンドを使うにはdaemonsが必要なので先に `gem install daemons`しておく。 オプションに`--log`を付けてスタートすることで、コマンドを実行したカレントディレクトリにtmpフォルダが作成されログが吐かれる。<br>
終了は`cloclworkd -c hoge.rb stop`

### **参考URL**

本家 <https://github.com/tomykaira/clockwork>

<http://www.ownway.info/Ruby/clockwork/about> <http://xoyip.hatenablog.com/entry/2014/02/17/222721> <http://qiita.com/giiko_/items/7e7c91a50f66bb351c89> <http://blog.codebook-10000.com/entry/20140325/1395673232> <http://d.hatena.ne.jp/riocampos+tech/20130625/p1>
