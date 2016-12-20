# CSVの読み込み
## seeds.rbを使ったデータの投入


```ruby
[db/seeds.rb]
require "csv"

CSV.foreach('db/sample.csv') do |row|
  Model.create(culum1: row[0], culum2: row[1], ...)
end
```

で`$ bundle exec rake db:seed`してやると指定したcsvファイルを読みこんでDBに追加してくれる。
