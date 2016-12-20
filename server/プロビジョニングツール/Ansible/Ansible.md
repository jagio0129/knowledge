# Ansible

Chefと同じくプロビジョニングツール,構成管理ツール。Infrastructure as a Code。Chefよりもシンプルに扱えるとのこと。

構成管理ツールの概要と利点については[ここ](http://www.slideshare.net/kk_Ataka/ansibleinfrastructure-as-code)がわかりやすい

ざっと見て、ChefとAnsibleの使い分けが必要。Chefは大規模向け、Ansibleは小さな環境向けといった感じ。

# 環境構築

[Ansibleチュートリアルをやってみた（Windowsユーザー向け）](http://celtislab.net/archives/20160127/ansible_tutorial_for_windows/)
を参考に。vagrantのversionは1.8.4を使うこと。1.8.5にはバグがある。

vagrant upでエラーが出るので[ここ](http://blog.a-way-out.net/blog/2016/03/11/vagrant-failed-to-mount-folders-in-linux-guest/)を参考に。

scpはCygwinを使ってないので直接node1にログインして行う。
node1は127.0.0.1の2001
node2は127.0.0.1の2002
どちらも`sudo yum update -y`する。

## 参考サイト

[Ansible Tutorial](http://yteraoka.github.io/ansible-tutorial/)
[Ansibleチュートリアルをやってみた（Windowsユーザー向け）](http://celtislab.net/archives/20160127/ansible_tutorial_for_windows/)
[Ansibleをはじめる人に。](http://qiita.com/t_nakayama0714/items/fe55ee56d6446f67113c)
[AnsibleによるInfrastructure as code入門 ( @kk_Ataka )](http://www.slideshare.net/kk_Ataka/ansibleinfrastructure-as-code)
