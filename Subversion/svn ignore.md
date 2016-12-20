たとえばcd share3内で

## 無視したいファイル/ディレクトリを設定する場合
# svn propedit svn:ignore ./ --editor-cmd=vim
で、指定すればよい。svnのデフォルトエディタがnanoだったためvimで開くようにオプションを付与。
ディレクトリを記述した場合、ディレクトリ内のファイル/ディレクトリはすべて無視されるので、
無視したくない場合はそのディレクトリ内でもう一度コマンドをたたきファイル名等を記述すればよい

## ignoreに設定したファイル・ディレクトリの確認
```
# svn status
M .
? test

# svn status --no-ignore
M .
? test
I tmp
```

以下例
```
# svn st
?       test
?       tmp
# svn propedit svn:ignore ./ --editor-cmd=vim <-ここでtmpフォルダを記述する
# svn st
M .     <-おそらくignoreを設定したことで何かが更新された
? test


# touch tmp/test.txt
M .     	<-tmp以下ももちろん除外対象
? test

```

# svn add/deleteに関して余談
addしたいファイル等が複数あるときは`svn add *`の全称記号が使えるけど
deleteしたいファイルが複数あるとき`svn delete *`は使えないふぁっ金
