Git Bashでfetchしたりpushするにはssh-agentを起動しssh-addで、登録している公開鍵の対になる秘密鍵を追加してやる必要がある。

コンソールを開くたびに手打ちで上記を行うのは面倒なので設定しておく。

1. **githubようにsshキーを作る**

  ```
  $ cd ~/.ssh
  $ ssh-keygen -t rsa
  ```

  パスワードを求められるが無視してエンター連打のほうがコンソールを開くたびにパスを求められることがない。

1. **公開鍵を登録**

  GitHubやBitBucketに公開鍵を登録

1. **~/.ssh/configで設定**

  ~/.ssh/configに(なければ作成)設定を記述しておく

  ```bash
  Host github
    User git
    Port 22
    HostName github.com
    IdentityFile [pri_path]
    TCPKeepAlive yes
    IdentitiesOnly yes
  ```

1. **~/.bashrcでコンソール起動時の設定をしておく**

  ここからが本題。

  コンソールを開くたびに`ssh-agent`を起動し、秘密鍵を登録しておく。

  ~/.bashrcに以下を記述

  ```bash
  # ssh-agent
  eval `ssh-agent`
  ssh-add [pri_path]
  ```

  このままではコンソールを終了してもssh-agentプロセスは終了せず、開き直すたびにプロセスがいくつも立ち上がってしまう。

  なので、コンソールが閉じるタイミングでプロセスをkillしてやる。

1. **~/.bash_logoutにコンソール終了時の処理を記述**

  ```bash
  # ssh-agent
  eval `ssh-agent -k`
  ```
