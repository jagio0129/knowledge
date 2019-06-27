# Rspecについて

## テストを書く順番について

1. 設計する
1. describe を書く
1. itを書く
1. subjectを明確にする
1. before(context)を明確にする

## 設計する
テストを書き始める前に、まず実装しようとしてるクラス、メソッドを簡単に設計します。

少なくとも、「クラス名」「クラスメソッド or インスタンスメソッド」「メソッド名」「メソッドの戻り値」ぐらいは決めます。

## letの使い方
letを使うとインスタンス変数を次のように使うことができる

```rb
# インスタンス変数を使う場合
before do
  @user = User.new(name: 'Taro', email: 'taro@example.com')
end

it 'is valid' do
  expect(@user).to be_valid
end

# letを使う場合
let(:user) { User.new(name: 'Taro', email: 'taro@example.com') }

it 'is valid' do
  expect(user).to be_valid
end
```

### メリット
1. typoにすぐ気付ける
  - letはメソッドのためtypoするとNameErrorが発生し、気づきやすい
1. 無駄な初期化の時間をなくせる
1. ローカル変数をそのままletに置き換えられる


## 参考サイト
- [初めてのRSpec](http://kentana-rails.hatenablog.com/entry/2014/02/22/233659)
- [RSpecのletを使うのはどんなときか？（翻訳）](http://qiita.com/jnchito/items/cdd9eef2ed193267c651)
