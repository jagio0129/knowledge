# coding: utf-8

# 実行ファイルと同じディレクトリに生成
cd = File.expand_path(File.dirname(__FILE__))

# 日付をyyyymmddで表示
now = Time.now.strftime('%Y%m%d')

# 拡張子の設定
extension = '.md'

FILE_PATH = "#{cd}/#{now}#{extension}"

File.open("#{FILE_PATH}",'w').close()