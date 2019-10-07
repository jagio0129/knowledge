- commit hash 
  - 89d1e617078c3bde96241af39178bd365c2b7c89
- example URL
  - https://gitlab.com/jagio0129

project一覧ページが表示されるので、おそらく`project_controller#index`が使われていると予想します。

```ruby
def index
  redirect_to(current_user ? root_path : explore_root_path)
end
```

処理は単純で、ログインしていれば`root_path`、そうでなければ`explore_root_path`へ飛ぶという処理です。
`root_path`と`explore_root_path`を見に行く前に`current_user`について見に行きます。

### current_user
`project_controller.rb`内で`current_user`は定義されていません。関係ありそうな`authenticate_user`がbefore_actionで呼ばれています。
```ruby
before_action :authenticate_user!, except: [:index, :show, :activity, :refs, :resolve]
```

これはgem `devise`で使えるようになるメソッドで、`current_user`もdeviseによって使えるようになります。

- https://qiita.com/tobita0000/items/866de191635e6d74e392

`authenticate_user!`でindexアクションがexceptされているのは、未ログイン時に`explore_root_path`に飛ばすようにしたいためだと思います。

### root_path
ログイン状態でindexアクションが実行されると`root_path`へと遷移します。`routes.rb`では
```ruby
root to: "root#index"
```

とあるので、root_controller#indexアクションが実行されます。
```ruby
def index
  # n+1: https://gitlab.com/gitlab-org/gitlab-foss/issues/40260
  Gitlab::GitalyClient.allow_n_plus_1_calls do
    super
  end
end
```
### Gitlab::GitalyClient.allow_n_plus_1_calls
`lib/gitlab/gitaly_client.rb`で定義されています。
```ruby
def self.allow_n_plus_1_calls
  return yield unless Gitlab::SafeRequestStore.active?

  begin
    increment_call_count(:gitaly_call_count_exception_block_depth)
    yield
  ensure
    decrement_call_count(:gitaly_call_count_exception_block_depth)
  end
end
```
`Gitlab::SafeRequestStore.active?`がfalseの場合にyield、つまりsuperである`Dashboard::ProjectsController`が戻り値となるようです。

### Gitlab::SafeRequestStore.active?
`lib/gitlab/safe_request_store.rb`で定義されていました。
```ruby
module Gitlab
  module SafeRequestStore
    NULL_STORE = Gitlab::NullRequestStore.new

    class << self
      # These methods should always run directly against RequestStore
      delegate :clear!, :begin!, :end!, :active?, to: :RequestStore

      # These methods will run against NullRequestStore if RequestStore is disabled
      delegate :read, :[], :write, :[]=, :exist?, :fetch, :delete, to: :store
    end
    .
    .
    .
```
`class << self`とあり、ブロック内のメソッドをクラスメソッドとして定義することができます。
- https://magazine.rubyist.net/articles/0046/0046-SingletonClassForBeginners.html

`#active?`はRequestStoreにdelegateされるため、`Gitlab::SafeRequestStore.active?`が呼び出すことができます。

RequestStoreの詳細は以下のリンクがわかりやすいです。
- https://github.com/steveklabnik/request_store
- http://nekorails.hatenablog.com/entry/2018/10/19/202853
- https://blog.freedom-man.com/requeststore-codereading

### Gitlab::GitalyClient.allow_n_plus_1_calls
再び`#allow_n_plus_1_calls`を見ていきます。
```ruby
def self.allow_n_plus_1_calls
  return yield unless Gitlab::SafeRequestStore.active?

  begin
    increment_call_count(:gitaly_call_count_exception_block_depth)
    yield
  ensure
    decrement_call_count(:gitaly_call_count_exception_block_depth)
  end
end
```
`increment_call_count(:gitaly_call_count_exception_block_depth)`を見ていきます。

```ruby
def self.increment_call_count(key)
  Gitlab::SafeRequestStore[key] ||= 0
  Gitlab::SafeRequestStore[key] += 1
end
private_class_method :increment_call_count
```
`private_class_method`によって、クラスメソッドをprivateメソッドにしています。
下記リンクにもあるように
> クラスメソッドがprivateになるのは、「private_class_methodを呼び出したクラスにおいて」です。親クラスのメソッドをサブクラスでprivateにした場合は、サブクラスではprivateになり、親クラスではpublicのままです。
- https://ref.xaio.jp/ruby/classes/module/private_class_method

つまり、`increment_call_count(:gitaly_call_count_exception_block_depth)`が呼ばれるたびに`gitaly_call_count_exception_block_depth`キーに対してvalueがインクリメントされるようになっています。

### What is gitaly?
gitalyが何なのかわからなかったので調べてみました。

> Gitaly is a Git RPC service for handling all the git calls made by GitLab
- https://gitlab.com/gitlab-org/gitaly

RPCについては以下の記事がわかりやすいです。
- https://qiita.com/il-m-yamagishi/items/8709de06be33e7051fd2

gitalyはGitLabが行ったすべてのgit呼び出しを処理するためのGit RPCサービスとなります。