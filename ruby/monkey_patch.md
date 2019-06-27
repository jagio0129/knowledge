# モンキーパッチ
オリジナルのソースコードを変更する実行時に動的言語のコードを拡張したり、変更したりする方法。rubyではメタプログラミングという手法でモンキーパッチを行う。

## やり方
同じクラスを再定義し直すだけ。

```rb
class Hoge
	def fuga
		"a"
	end
end

Hoge.new.fuga #=> "a"

class Hoge
	def fuga
		"b"
	end
end

Hoge.new.fuga #=> "b"
```

## どんなときに使うか
1. Gemを少しだけ直したい
2. 組み込みライブラリにメソッドを足したい

## Refinement
**モンキーパッチの適用範囲を制限できる**

```rb
class Hoge
	def fuga
		"a"
	end
end

module Piyo
	refine Hoge do
		def fuga
			"b"
		end
	end
end

Hoge.new.fuga #=> "a"
using Piyo
Hoge.new.fuga #=> "b"
```

### Refinementのスコープ

```rb
class A
	def b
	end
end

using M
# Usingより下の行は全て対象
module B
	# classの中でも対象

	def b
		# methodの中でも対象
	end
end
# クラス定義が終わっても対象
```

```rb
class A
	def b
	end

	using M

	def b
		# methodのなかでも対象
	end
end
# クラスのスコープから外れると対象外
module B
	def b
	end
end
```

> メソッドやブロックの中では使えない

## 参考
- http://sssslide.com/speakerdeck.com/sutetotanuki/rubymonkihatutifalseshi-jie
- https://blog.kazu69.net/2014/11/23/examined-how-to-override-monkey-patch-methods-in-ruby/
