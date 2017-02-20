# gemパッケージの作り方

## 準備
- gem `bundler`が必要

```
# bundler未インストールの場合はインストール
gem install bundler
```

## 雛形の生成

```
# test_gemの雛形を作成(rspec)
bundle gem test_gem -t
```
- 「-t」オプション
	- テストコードを配置するためのディレクトリとテストを実行するためのヘルパーを生成
- 「-b」オプション
	- 実行可能なコマンドの雛形を一緒に生成

Rails pluginのGemを作成する場合には`gem install rails`をした上で以下のコマンドを実行

```
# test unitをスキップしたpluginの作成
rails plugin new testgem -T --skip-test-unit --mountable
```

## bundle gemで生成されるファイル

ファイル名|説明
---|---
Gemfile|Bundlerがgemパッケージの依存関係を解決するために利用するファイル
Rakefile|gemパッケージのビルドやリリースのためのタスクが定義されている
LICENSE.txt|gemパッケージのライセンスについて記述するファイル。雛形生成時はMITライセンスとして記述されている。
gem_hoge.gemspec|gemパッケージの構成や詳細情報を記述するファイル
lib/gem_hoge.rb|gemパッケージのメインとなるソースコード
lib/gem_hoge./version.rb|gemパッケージのバージョンを記述しておくソースコード

## .gemspecの修正
```rb
# このgemの説明を書く
spec.summary       = %q{TODO: Write a gem summary}
spec.description   = %q{TODO: Write a gem description}

# このgemのHomepageを書く
spec.homepage      = 'http://morizyun.github.io'

# 依存するgemが存在する場合のみ、以下のように指定
spec.add_dependency 'xxxx', '~>x.x'

# 開発時だけに必要な依存gemが存在する場合のみ、以下のように指定
spec.add_development_dependency 'yyyy', '~>y.y'
```

> **gemspecの注意点**
> gemspecファイル内に「TODO」を残したままだたとgemパッケージとしてビルドする際にエラーになること。雛形にはないが「FIXME」も残したままだとエラーとなる。

## gemの実装
- 実際のコードは主にlibディレクトリ以下に記述していく。

## 実行
- 同ディレクトで`bundle install`
	- errorが出る場合はエラー文をよく読み解消
- `bundle exec irb`でirbを起動し、
	```rb
	require 'test_gem'
	=> true
	TestGem.greet
	=> 'Hello World'
	```

## gemのパッケージ化
```rb
gem build test_gem.gemspec
```

## gemの公開
- 'https://rubygems.org/'でアカウント登録が必要。
- アカウントを作成するとAPIKEYが発行される。
- `rake release`コマンドでリリース。
