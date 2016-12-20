# Git まとめ
=============================
## 用語
### ワークツリー
実際に作業しているディレクトリ

### インデックス
ワークツリーとリポジトリの間に存在
コミットするときはワークツリーから一度インデクスに記録する(add)

### Push
ローカルリポジトリの変更履歴をリモートリポジトリにアップロードする操作

### Clone
リモートリポジトリのファイルをローカルに複製する
ファイルだけでなく変更履歴も複製される

### Pull
リモートリポジトリの変更をローカルに取り込む

## git コマンド
- `git init`  
cdをgitリポジトリに指定  
- `git status`  
状態の確認
- `git add <file>`  
indexにファイルをステージング
- `git commit -m "<コメント>"`
コミットする
-mオプションでコメントも指定できる
コメント無しだとエディタが立ち上がりコメントを記述できる
<file>を追跡対象に追加
- `git log`  
リポジトリの変更履歴を取得
- `git remote add <name> <url>`  
pushするremoteの指定
<name>にはだいたいoriginが入る
<name>を省略した際にはデフォルトでoriginが入る
- `git push <repository> <refspec>`　　
remoteのoriginにpushする
-uオプションで次回からブランチ名を省略できる

- `$ git config --global alias.tree 'log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s"'`
コマンドラインでgit ligを見やすくしてくれる。`git tree`で使用。



- `git config --list/-l`  
configの一覧取得  
- `git config user.name/.email`  
username/useremailの確認


### コミットコメントの書き方
```
1行目：コミットでの変更内容の要約
2行目：空白
3行目：変更した理由
```

### CentOSに最新のgitをインストールする
#### epelリポジトリ導入
`$ rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm`

#### wingリポジトリ導入
```
$ cd /etc/yum.repos.d/
$ wget http://wing-repo.net/wing/6/EL6.wing.repo
```
#### gitのインストール
```
$ yum --enablerepo=wing install git
```

### Gitに含まれるファイルについて
#### README
プロジェクトに関する説明と、どう使えばいいか、どうやって貢献したらいいかなどが記載

#### .gitignore
Gitに追跡しないでほしいもの一覧。パスワードが入ったファイルや環境ごとで異なるconfigファイルなど

### CentOSのCLでGitコマンドの補完機能を有効にする
```
# git-completion.bash の在処を探す
find / -name git-completion.bash

# 必要に応じて git-completion.bash を任意の場所にコピー

# .bashrc に git-completion.bash を読み込むように記す
vi ~/.bashrc
# 例えば、以下のような感じ
source /usr/share/doc/git-1.7.1/contrib/completion/git-completion.bash

# .bashrc の再読み込み
source ~/.bashrc
```



### Git実践練習サイト
- [Git入門：Git初学習者のための効率的な学習方法を考えてみた](http://blog.takanabe.tokyo/2014/12/13/74/)  

- [http://k.swd.cc/learnGitBranching-ja/]
- [実践でわかる！ブランチとコンフリクト、リバートを解説します | Git ...](http://liginc.co.jp/241697)
