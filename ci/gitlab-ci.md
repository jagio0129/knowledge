GitLab CI
===
## 特徴
- CIがGitLabに統合されているので、Jenkinsのように別で構築する必要がない
- GitLab CI Runner(JenkinsでいうSlaveのようなもの)をインストールしたサーバが必要
- jobとstageという概念があり、stage1のjob1とjob2を並列実行できる。これらが終了すればstage2のjob3とjob4が実行されるといった設定もできる
- ブランチをpushすれば自動でビルドが実行される
- リポジトリのトップやMergeRequestの画面にビルド結果が表示される

## Runner
Runnerには2種類ある

### Shared runners
- GitLab全体で共有しているRunner
- 自前でRunner環境を構築しなくても良くなる。

### Specific runners
- GitLabからSSHできるサーバであればrunnerにできる
- リポジトリ個別にrunnerを建てることもできるので、他のプロジェクトのビルドが完了するまで待たされるということがない。
- Runnerにプロジェクト固有の設定を追加できる
- 別ユーザーと隔離された環境で自分のプロジェクトのジョブを実行できるのでセキュリティレベルを担保しやすい

## executer
GitLab Runnerのジョブ実行方式を指定できる。以下の7種類が用意されている。

- Shell
- Docker
- Docker Machine and Docker Machine SSH (autoscaling)
- Parallels
- VirtualBox
- SSH
- Kubernetes

Shellであれば、Runnerがインストールされた環境でshellベースで実行される。

## パイプラインの定義
Runnerでジョブを実行させるにはリポジトリ直下に `.gitlab-ci.yml`を用意して設定を記述していく。

### image
ジョブの実行に使うDockerイメージを指定する。各ジョブごとに個別に指定することも可能。

### variables
パイプライン全体で使用する環境変数を定義。ここで定義した環境変数はGitLab Runnerが起動するDockerコンテナの中から参照することが可能となる。

### stages
パイプラインのステージを定義。

その他の設定パラメータは[こちら](https://qiita.com/ynott/items/1ff698868ef85e50f5a1#%E8%A8%AD%E5%AE%9A%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E3%83%BC)を参照。

## Tips
rspecのjobを並列で動かしたい場合はpararellを設定すろと良さそう
- https://qiita.com/ynott/items/1ff698868ef85e50f5a1#parallel

CIでRspec高速化の参考になりそう
- https://www.neotericdesign.com/articles/2018/04/running-your-rails-test-suite-with-dockerized-selenium-on-gitlab-ci/

## 参考サイト
- GitLab RunnerでCI/CDしてみる(前編)
  - https://dev.classmethod.jp/ci/gitlab-runner-ci-cd-1/
- GitLab CIでRailsアプリをお手軽CI開発する
  - https://tech.drecom.co.jp/easy-ci-development-using-gitlab-ci/
- GitLab CI/CDパイプライン設定リファレンス(日本語訳:GitLab CI/CD Pipeline Configuration Reference)
  - https://qiita.com/ynott/items/1ff698868ef85e50f5a1
- GitLab CI上でRailsアプリをRSpec(System Spec)でdocker-seleniumを利用してE2Eテストした話
  - https://qiita.com/kochoru/items/260731fa67ea70987cf5