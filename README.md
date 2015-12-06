# Matsuya

既存の松屋のメニューを参考にして、ありそうなメニューを適当に作ります。たまに実在するメニューも出てきます。

## Installation

bundle

```ruby
gem 'matsuya'
```

こうじゃ

    $ bundle

こっちでもいいかな

    $ gem install matsuya

## Usage
### シェルから使う
`gem install`した場合は、以下のようなコマンドを入力するとなにか出てきます。
```
% matsuya
牛めし
% matsuya
牛めし
% matsuya
めし
% matsuya -o 0.8
オリジナルチリソースハンバーグ定食
% matsuya
プレミアムカルビキムカル丼
%
```
キツい

コマンドラインオプションについては -h オプションをつけてくれ

### ライブラリとして
```ruby
require 'matsuya'

puts Matsuya.order
puts Matsuya.order(0)
puts Matsuya.order(0.8)
```

output:

```
キムチチゲ膳（プレミアム牛肉使用）
プレミアム旨辛ネギ塩豚バラ生姜焼定食
シャンピニオンソース豆腐カレー
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/matsuya/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
