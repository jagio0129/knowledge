# rbenv まとめ

rbenvを使用することで、使いたいRubyのバージョンをインストールできる。また、インストール済みであればバージョンの変更も簡単に行うことができる。

## How to rbenv install for CentOS

### 1\. 必要なパッケージのインストール

```
$ yum install -y git gcc gcc-c++ openssl-devel readline-devel
```

### 2\. rbenv install(全ユーザで使えるように)

```
$ sudo su -
$ git clone git://github.com/sstephenson/rbenv.git /usr/local/src/rbenv
$ echo 'export RBENV_ROOT="/usr/local/src/rbenv"' >> /etc/profile.d/rbenv.sh
$ echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> /etc/profile.d/rbenv.sh
$ echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
$ source /etc/profile.d/rbenv.sh
$ rbenv -v
rbenv 0.4.0-151-g83ac0fb
$ su - vagrant
$ rbenv -v
rbenv 0.4.0-151-g83ac0fb
```

### 3\. ruby-build install

```
$ git clone git://github.com/sstephenson/ruby-build.git /usr/local/src/rbenv/plugins/ruby-build
```

### 4\. Ruby install

```
$ rbenv install 2.2.2
$ rbenv global 2.2.2
$ ruby -v
ruby 2.2.2p95 (2015-04-13 revision 50295) [x86_64-linux]
```

## rbenv update方法

rbenv-updateをつかう

```
$ mkdir -p "$(rbenv root)/plugins"
$ git clone https://github.com/rkh/rbenv-update.git "$(rbenv root)/plugins/rbenv-update"
```

rbenv-updateをインストールしたのでrbenv updateでアップデートする。

```
$ rbenv update
```

## rbenv コマンド

### インストール可能なバージョン一覧

```
$ rbenv install -l
```

### ruby install

```
$ rbenv install <version>
```

### インストールしたバージョンの一覧表示

```
$ rbenv versions
```

### バージョンの切り替え

- 1.9.3-p385に切り替え

  ```
  $ rbenv global 1.9.3-p385
  ```

- システムデフォルトに戻す

  ```
  $ rbenv gloval system
  ```

- 特定ディレクトリのバージョンを1.9.3-p385に切り替え

  ```
  $ rbenv local 1.9.3-p385
  ```

- 特定ディレクトリのバージョン切り替えを解除

  ```
  $ rbenv local --unset
  ```

#### Ruby,Gemインストール後の反映

```
$ rbenv rehash
```

#### Ruby uninstall

```
$ rbenv uninstall 1.9.3-p385
```
