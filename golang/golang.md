# Go言語、golang
- 2009年にgoogleより発表された言語

# 1.特徴
- シンプルな言語仕様で学習が比較的容易
- 巨大なコードでも高速にコンパイルできるため大規模開発にも向いている
- Win、OSX、Linuxなどの環境に合わせた実行ファイルを生成するクロスコンパイルの仕組みがあるため、作成したプログラムを容易に配布できる。
- 並行処理のサポートも充実しており、ミドルウェアの開発などにも適している。
- CやC++などが使用されるシステムプログラミング領域で、より効率よくプログラムを書くことを目的に作られた。

## 言語をシンプルに保つ
他の言語が持つような機能の多くを削り、言語をシンプルに保っている。

**最小限の構文**
- 繰り返し構文はfor文しかない。
- 三項演算子はない

## ツールのサポート
Goには開発を支援するコマンドが同梱されており、様々なツールを使用できる

コマンド|用途
---|---
go build|プログラムのビルド
go fmt|Goの規約に合わせてプログラムを整形
go get|外部パッケージの取得
go install|プログラムのビルドとインストール
go run|プログラムのビルドと実行
go test|テストやベンチマークの実行
go tool yacc|パーサをGoで出力するGo実装のyacc(パーサジェネレータ)
godoc|ソースからドキュメントの生成

## クロスコンパイル
例えば、Linux64ビット用の実行ファイルを、OSXのマシンで生成したい場合は、OSX上でLinux64ビット用のコンパイラをインストールするために、事前に次のようにGOOSとGOARCHという変数を指定してバッチファイルを実行する必要がある

```
$ cd go/src # Goのインストールディレクトリのsrc
$ GOOS=linux GOARCH=amd64 ./make.bash --no-clean
```

準備が終われば以下のようにして目的の実行ファイルが生成できる

```
$ GOOS=linux GOARCH=amd64 go build hello.go
```

## プロジェクト構成とパッケージ
プロジェクト内はbin,pkg,srcディレクトリを作成するのが一般的
```
myproject
├── bin # go install時の格納先
├── pkg # 依存パッケージのオブジェクトファイル
└── src # プログラムのソースコード
```

### 環境変数GOPATHの指定
```
$ cd myproject
$ export GOPATH=`pwd` # myprojectをGOPATHに登録
```

### パッケージの作成
Goでは1つのパッケージは1つのディレクトリに格納する。

### buildとrun
正しくGOPATHが設定された状態でgo runコマンドでmain.goを実行すると、gosampleパッケージの場所が正しく解決され、プログラムを実行できる。
```
$ cd $GOPATH/src/main
$ go run main.go
hello world
```

次にビルドして一つの実行形式のファイルを生成する。go buildコマンドを用いてその場に実行ファイルを作ることもできるが、go installコマンドを用いると、生成されたファイルが$GOPATH/binに自動的に格納される。
```
$ cd $GOPATH/src/main
$ go install
```

build後のプロジェクト内は次のようになる。
```
myproject
├── bin
│ └── main
├── pkg
│ └── darwin_amd64
│ └── gosample.a
└── src
    └── gosample
    ｜  └── gosample.go
    └── main
        └── main.go
```

# 2.言語仕様
## インポート
```go
import(
    "fmt"
)

func main(){
    fmt.Println("hello world")
}
```
インポートしたパッケージ内には、`パッケージ名.Hoge()`でアクセス。

### オプションの指定
```go
import(
    f "fmt"
    _ "github.com/hoge/fuga"
    . "strings"
)

func main(){
    // fmt.Println() => f.Println()
    // strings.ToUpper() => ToUpper()
    f.Println(ToUpper("hello world")) // => "HELLO WORLD"
}
```

- `_`はインポートしたパッケージをコンパイルしないことを意味する。
- インポートしたパッケージを使用していないとエラーとなる。

## 組み込み型

型|説明
---|---
uint8|8ビット符号なし整数
int8|8ビット符号あり整数
float32|32ビット浮動小数
comlex64|64ビット複素数
byte|uint8のエイリアス
rune|Unicodeのコードポイント
uint|32か64ビットの符号なし整数
int|32か64ビットの符号あり整数
uintptr|ポインタ値用符号なし整数
error|エラーを表すインターフェイス

- runeは他の言語でいうchar
- stringが""、runeは''、複数行ヒアドキュメントは``

## 変数
```go
var message string = "hello world" // `var 変数 型`が基本

// 複数宣言
var (
    a string = "aaa"
    b = "bbb"
    c = "ccc"
)
```

### 関数内部での宣言と初期化
関数内部では、varと型宣言を`:=`で省略できる

```go
func main(){
    // var message string = "hello world"
    message := "hello world"
}
```

## 定数
```go
func main(){
    const Hello string = "hello"
    Hello = "bye"  // cannot assign to Hello
}
```

## ゼロ値
明示的に値を初期化しなかった場合の値。型ごとに異なる。

型|ゼロ値
---|---
整数型|0
浮動小数点型|0.0
bool|false
string|""
配列|各要素がゼロ値の配列
構造体|各フィールドがゼロ値の構造体
その他の型|nil

## if
goではif条件部に`()`はいらない

```go
func main() {
    a, b := 10, 100
    if a > b {
        fmt.Println("a is larger than b")
    } else if a < b {
        fmt.Println("a is smaller than b")
    } else {
        fmt.Println("a equals b")
    }
}
```

## for
goではfor条件部に`()`はいらない

```go
func main() {
    for i := 0; i < 10; i++ {
        fmt.Println(i)
    }
}
```

## whileもforで
```go
n := 0
for n < 10 {
    fmt.Printf("n = %d\n", n)
    n++
}
```

## 無限ループ
```go
for {
    doSomething()
}
```

## break, continue
- ループの終了 => break
- 最初から処理を再開 => continue

```go
func main() {
    n := 0
    for {
        n++
        if n > 10 {
            break // ループを抜ける
        }
        if n%2 == 0 {
            continue // 偶数なら次の繰り返しに移る
        }
        fmt.Println(n) // 奇数のみ表示
    }
}
```

## switch
```go
func main() {
    n := 10
    switch n {
    case 15:
        fmt.Println("FizzBuzz")
    case 5, 10:
        fmt.Println("Buzz")
    case 3, 6, 9:
        fmt.Println("Fizz")
    default:
        fmt.Println(n)
    }
}
```
- どのcaseにも該当しなかったらdefaultが実行される
- 他の言語と違い、**breakを書かなくても該当case内しか実行されない**
    - 次のcaseに処理を進めたいときは`fallthrough`と明示する


# 参考サイト
- http://gihyo.jp/dev/feature/01/go_4beginners/0001