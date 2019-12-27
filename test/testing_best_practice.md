Testing best practices
===

> GitLabのテストにおけるベストプラクティス記事を日本語訳したものです。
> https://docs.gitlab.com/ee/development/testing_guide/best_practices.html#system--feature-tests

## [Test Design](https://docs.gitlab.com/ee/development/testing_guide/best_practices.html#test-design)
GitLabではテストは最優先事項対象[1]です。機能の設計と同様に、テストの設計を考慮することは重要と考えています。

機能を実装するとき、我々は適切な機能を適切な方法で開発することを検討します。これにより、範囲を管理可能なレベルに絞り込むことができます。機能のテストを実装する場合、適切なテスト実装を検討する必要がありますが、重要な箇所をすべてカバーするテストは難しく、すぐに管理困難な段階にまで拡大するでしょう。

テストヒューリスティック[2]は、この問題の解決に役立ちます。これは、我々のコードに潜むバグを明らかにし、簡潔に対処します。テストを設計する時、既知のテストヒューリスティックの確認に時間をかけ、我々のテスト設計を周知してください。[Test Engineering section](https://about.gitlab.com/handbook/engineering/quality/test-engineering/#test-heuristics)で有用なヒューリスティックのドキュメントが読めます。

## [Test speed](https://docs.gitlab.com/ee/development/testing_guide/best_practices.html#test-speed)
GitLabには大規模なテストスイートがあり、[並列化](https://docs.gitlab.com/ee/development/testing_guide/ci.html#test-suite-parallelization-on-the-ci)しないと実行に数時間かかることがあります。正確で効果的かつ高速なテストを書く努力をすることが重要です。

テストのパフォーマンスに関する注意事項を次に示します。

- `double`と`spy`は`FactoryBot.build(...)`より速い
- `FactoryBot.build(...)`と`.build_stubbed`は`.create`より速い
- `build`, `build_stubbed`, `attributes_for`, `spy`, `double`を使う時、`create`でオブジェクトを作成しないこと。DBの永続化は遅い。
- 本当にテストする必要がある場合以外は、JavaScriptを必要とする機能のテスト(RSpecの`:js`のような)を行わないこと。ヘッドレスブラウザでのテストは遅い。

## [RSpec](https://docs.gitlab.com/ee/development/testing_guide/best_practices.html#test-speed)

rspecでテストするには

```ruby
# run all tests
bundle exec rspec

# run test for path
bundle exec rspec spec/[path]/[to]/[spec].rb
```

[guard](https://github.com/guard/guard)を使用して変更を継続的に監視し、変更されたテストのみを実行します。

```ruby
bundle exec guard
```

springとguardを一緒に使用する場合は、代わりに`SPRING = 1 bundle exec guard`としてspringを使用してください。

## [General guidelines](https://docs.gitlab.com/ee/development/testing_guide/best_practices.html#test-speed)

- トップレベルには`describe ClassName`を一つだけ定義すること
- `describe`内では、クラスメソッドを`.method`、インスタンスメソッドを`#method`と表記すること
- ロジック的に分岐する場合は`context`を使うこと
- テスト項目の順序はプロダクトコードクラス内の順序と一致させること
- 改行を使用してフェーズを分離し、[4フェーズのテストパターン](https://thoughtbot.com/blog/four-phase-test)に従うこと
- `localhost`のようなハードコーディングはせず、`Gitlab.config.gitlab.host`のように設定変数を使うこと
- `sequence`によって生成された変数のような値に対してテストを行わないこと([落とし穴](https://docs.gitlab.com/ee/development/gotchas.html#do-not-assert-against-the-absolute-value-of-a-sequence-generated-attribute)を参照)
- `before`や`after`などのフックの引数に`:each`(alias `:example`)与えてもデフォルトで効いているため引数に指定しないこと
- `before`と`after`のフックは`:all`のスコープよりも`:context`のスコープのほうが望ましい
- 指定した要素に作用する`evaluate_script("$('.js-foo').testSomething()"`) (もしくは`execute_script`)を使うときは、Capybaraのマッチャー(例えば`find('.js-foo')`)であらかじめ要素が確実に存在することを確かめる
- `focus: true`を使ってテストしたい範囲を分離すること
- テストに複数の期待値がある場合は`[aggregate_failures](https://qiita.com/jnchito/items/3a590480ee291a70027c#1-%E7%89%B9%E5%AE%9A%E3%81%AE%E3%82%A8%E3%82%AF%E3%82%B9%E3%83%9A%E3%82%AF%E3%83%86%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E7%BE%A4%E3%82%92%E3%81%BE%E3%81%A8%E3%82%81%E3%81%A6%E6%A4%9C%E8%A8%BC%E3%81%A7%E3%81%8D%E3%82%8Baggregate_failures-%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89)`を使用すること

## [System / Feature tests](https://docs.gitlab.com/ee/development/testing_guide/best_practices.html#test-speed)

> Note: 新しいSystem / Feature testを書く前に、一度、[書かないことを検討してください](https://docs.gitlab.com/ee/development/testing_guide/testing_levels.html#consider-not-writing-a-system-test)

- feature specのファイル名は`user_changes_password_spec.rb`のように`ROLE_ACTION_spec.rb`とすべき
- シナリオタイトルには成功ケースと失敗ケースを記載すること
- 「successfully」など、情報がないようなシナリオタイトルは避けること
  - 何がsuccessfullyなのか明記すること
- 機能のタイトルを繰り返すだけのシナリオタイトルは避けること
- データベースには必要なレコードのみを作成すること
- Happy path[3]とless happy pathだけをテストします。
- 可能な限り単体テストまたは統合テストでテストする必要がある
- ActiveRecord内部ではなくページに表示されるものを評価すること
  - もしレコードが作成されたことを確認したかったら、`Model.count`等でモデルが増えたことをテストするのではなく、その項目がページに表示されるというテストを追加すること。
- DOM要素を探してもよいがテストをより脆弱にするため乱用はしないこと


## [Live debug](https://docs.gitlab.com/ee/development/testing_guide/best_practices.html#test-speed)

`live_debug`メソッド[4]を使えば、Capybaraを一時停止して、ブラウザでウェブサイトを表示できます。デフォルトブラウザで開きます。テストの実行を再開するには、任意のキーを押します。

以下のような感じです。

```
$ bin/rspec spec/features/auto_deploy_spec.rb:34
Running via Spring preloader in process 8999
Run options: include {:locations=>{"./spec/features/auto_deploy_spec.rb"=>[34]}}

Current example is paused for live debugging
The current user credentials are: user2 / 12345678
Press any key to resume the execution of the example!
Back to the example!
.

Finished in 34.51 seconds (files took 0.76702 seconds to load)
1 example, 0 failures
```

> Note: `live_debug`はJavaScriptが使える場合でのみ動きます。


## [Run :js spec in a visible browser](https://docs.gitlab.com/ee/development/testing_guide/best_practices.html#run-js-spec-in-a-visible-browser)

以下のように`CHROME_HEADLESS=0`を付けてspecを実行します。

```
CHROME_HEADLESS=0 bundle exec rspec some_spec.rb
```

このテストはすぐに終わりますが、これにより何が起こっているのかわかります。`CHROME_HEADLESS=0`を付け `live_debug`を使って開いているブラウザを一時停止し、再び開くことができません。これは要素のデバッグと検査に使用できます。

byebugまたはbinding.pryを追加して、実行を一時停止し、テストを[ステップ実行](https://docs.gitlab.com/ee/development/pry_debugging.html#stepping)することもできます。

## [Screenshots](https://docs.gitlab.com/ee/development/testing_guide/best_practices.html#screenshots)

`capybara-screenshot`gemを使用して失敗時に自動的にスクリーンショットを撮ります。 CIでは、これらのファイルをジョブアーティファクトとしてダウンロードできます。

また、以下のメソッドを追加することにより、テストの任意の時点でスクリーンショットを手動で取得できます。不要になったら削除してください！詳細については、[ここ](https：//github.com/mattheworiordan/capybara-screenshot#manual-screenshots)を参照してください。

- `screenshot_and_save_page`
  - Capybaraが「見ているもの」のスクリーンショットを作成し、ページソース(htmlファイル等)を保存します。
- `screenshot_and_open_image `
  - Capybaraが「見ているも」のをスクリーンショット化し、画像を自動的に開きます。

これにより作成されたHTMLダンプにはCSSがありません。これにより、実際のアプリケーションとは大きく異なった外観になります。デバッグを容易にするCSSを追加する[small hack](https://gitlab.com/gitlab-org/gitlab-foss/snippets/1718469)があります。

## [Fast unit tests](https://docs.gitlab.com/ee/development/testing_guide/best_practices.html#fast-unit-tests)

一部のクラスはRailsから十分に分離されており、RailsやBunlderの`:default`グループのgemn等によって追加されたオーバーヘッドなしでそれらをテストできるはずです。このような場合、テストファイルで`spec_helper`をreuqireする代わりに`fast_spec_helper`をreuqireできます。次の理由からテストは非常に高速に実行されるはずです。

- gemのロードをスキップ
- Railsアプリの起動をスキップ
- GitLab ShellとGitallyのスキップ
- テストリポジトリのセットアップをスキップ

`fast_spec_helper`はlibディレクトリ配下にある自動ロードクラスもサポートします。つまり、クラス/モジュールがlibディレクトリ配下のコード飲みを使用している限り、依存関係を明示的にロードする必要はありません。`fast_spec_helper`は、Rails環境で一般的に使用されるコア拡張機能を含む、すべてのActiveSupport拡張機能もロードします。

場合によっては、コードがgemを使用している場合、または依存関係がlibにない場合、require_dependencyを使用して依存関係をロードする必要があることに注意してください。

たとえば、`Gitlab::UntrustedRegexp`クラスを呼び出しているコードをテストする場合は、内部でre2ライブラリを使用します。re2 gemを必要とするライブラリ内のファイルに`require_dependency 're2'`を追加して、この要件を作成する必要があります 明示的に指定するか、仕様自体に追加することもできますが、前者が優先されます。

`spec_helper`の場合に30秒以上書かkるloadが、`fast_spec_helper`を使うことで1秒程度のロードで
## let variables

GitLabのRSpecスイートでは、重複を減らすために`let`（それに加えて、厳密な非遅延バージョン`let！`）変数を広範囲に使用しています。しかしながらこれは時々[コードを分かりにくく](https://thoughtbot.com/blog/lets-not)します。そのため、今後の使用に関するガイドラインを設定する必要があります。

- `let!`はインスタンス変数よりも好ましい。`let`は`let!`よりも好ましい。ローカル変数は`let`よりも望ましい
- `let`を使用してspecファイル全体の重複を減らせる
- 単一のテストでのみ使用される変数は`let`を使わずにitブロック内でローカル変数として定義すること
- 最上位の記述ブロック内でlet変数を定義しないこと。これは、より深くネストされたコンテキストまたは記述ブロックでのみ使用される。定義は使用する場所にできるだけ近づけること。
  - 解せない
- ある`let`変数の定義を別の`let`変数の定義で上書きしないようにする
  - これもスコープが異なっていればいいのでは？
- 別で定義されている`let`変数を定義するな(たぶん糸の異なる重複定義するなってことだと思われ)
  - 代わりにヘルパーメソッドを使うべき
- `let!`変数は定義された順序が重要な場合にのみ使用すること。それ以外は`let`で十分
  - `let`は遅延評価であり、参照されるまで評価されないことに注意して

## Common test setup
`let_it_be`の話。あまり共感できなかったのでとばす

## Time-sensitive tests
TimecopはRubyベースで利用でき、時間依存のテストケースに有効です。時間依存で何かを実行・検証する場合、Timecopを使用して一時的なテストの失敗を防ぐ必要がある。

## 注釈
- [1] first class citizenの訳がふわっとしていた(一級市民 or 第一級オブジェクト)ので[この記事](https://news.mynavi.jp/article/20090609-mozilla/3)をみて「最優先事項」との訳にした
- [2] [ヒューリスティック評価](https://u-site.jp/usability/evaluation/heuristic-evaluation/)：経験則（ヒューリスティックス）に基づいてユーザビリティを評価し、UI上の問題を発見する手法。ここでは「テストにおける経験則・ナレッジ」の意味合いに近い
- [3] 最も使用頻度の高いユースケースのテストを[ハッピーテスト](https://twitter.com/krsna_sub/status/310588701807869953)っていうんですね。知らなんだ...
- [4] `live_debug`なんてメソッドCapybaraにもRspecにもいないぞと[思ったらこういうこと](https://www.reddit.com/r/ruby/comments/9ggna7/some_good_advices_about_rspec_and_capybara_from/)でした
