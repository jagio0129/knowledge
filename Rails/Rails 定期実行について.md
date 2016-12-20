# Rails 定期実行について
clockworkを使う

Railsの場合はclockworkをrequireしたあとでRailsの環境をrequireすることでRailsのコードを使えるようになる。
Railsの環境を読み込むには`config/boot`と`config/environment`をrequireする。requireする際のパスに注意して書く必要があるが、clockworkの今ふぃ具ファイルが`boot`などと同じく`config`にある場合は、

```rb
require File.expand_path('../boot', __FILE__)
require File.expand_path('../environment', __FILE__)
```
などと書く。

これをやっておくことでRailsのモデルなどにアクセスできるようになって、より実践的な使いかたをできるようになる。

```rb
require 'clockwork'

require File.expand_path('../boot', __FILE__)
require File.expand_path('../environment', __FILE__)

module Clockwork

  handler do |job|
    p "#{job}: user count => #{User.count}"
  end

  every(1.minute, 'minute')
end
```

## 参考サイト
- [Rubyでcronのような定期実行を実現するclockwork](http://xoyip.hatenablog.com/entry/2014/02/17/222721)
