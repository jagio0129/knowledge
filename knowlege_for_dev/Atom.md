Atom　カスタマイズ
==========================
## キーバインド for Windows
### 文字・行関連  

|操作|コマンド|
|:--||
|単語の末尾に移動|Alt+f|
|単語の先頭に移動|Alt+b|
|行の下に空行を挿入|Ctrl+Enter

### 画面操作系
|操作|コマンド|
|:--||
|画面を右に分割|Ctrl+kしたあと→|
|画面を閉じる|Ctrl+w|
|閉じたタブを復元|Ctrl+Shift+t|
|ツリービュー表示/非表示|Ctrl+￥|
|設定画面|Ctrl+,|
|コマンドパレット|Ctrl+Shift+p|
|Markdownプレビュー|Ctrl+Shift+m|
|タブ移動|Ctrl+Tab|

### その他
好みでキーバインドを変更、追加

```
'atom-workspace atom-text-editor:not([mini])':
# 行末へ移動
  'ctrl-e' : 'editor:move-to-end-of-screen-line'
# ツリービューとエディタでフォーカス切り替え
  'ctrl-0' : 'tree-view:toggle-focus'
```

## Packages
#### 参考サイト
- [ATOMおすすめパッケージ 2015年末版 - Qiita](http://qiita.com/saison/items/e241cb538ff23d1bf386)  
- [【超おすすめ！！】Atomのパッケージ、テーマ、キーバインディング、設定を紹介してみる（※随時更新）](http://qiita.com/snowsunny/items/f40c3291a580f3215797)

### (番外)　sync-settings
Atomの設定やインストールしたパッケージなどのバックアップを作成しgistに保存できることで他の環境のAtomでも同様のsetting、パッケージを適応することができる

- ** sync-settingsのインストール   **  
  1. コマンドまたは設定よりsync-settingsをインストールする  
  `$ apm install sync-settings`

  2. personal access tokenとgist idを入力  
  gistを使用するためGitHubアカウントが必要  
  取得方法は[ここ](http://qiita.com/T_M/items/0fb0804eb1fd256aac4e)を参照  

- ** 使い方 **  
Ctrl+Shift+pよりsync settingsと押下すると補完が出る

| 説明 | コマンド |
| :------------- | :------------- |
| 設定をバックアップ(アップロード)     | :Backup
| 設定をダウンロード | :Restore
| バックアップ済みの設定を確認 | :View Backup  
| 新規のバックアップが無いか確認 | :Check Backup
  * 参考
[http://qiita.com/__mick/items/b0a98441ed9b1793184a]
