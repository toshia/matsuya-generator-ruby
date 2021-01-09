# -*- coding: utf-8 -*-

require 'matsuya/version'
require 'set'

module Matsuya
  # 松屋の商品。価格は、牛めしなら並盛など、標準の量と思われるものを入れておく
  Menu = Struct.new(:pattern, :price)

  # 松屋に実際にあるメニュー。
  # 牛めしのようにプレミアムとそうでないものがある場合は、プレミアムだけを書く
  # オリジナルカレギュウ（プレミアム牛肉使用）も、プレミアムとして扱い、プレミアム牛肉使用と書いていないほうは書かない
  Sample = Set.new([Menu.new(%i[プレミアム 牛 めし], 380),
                    Menu.new(%i[ネギ たっぷり プレミアム 旨 辛 ネギ 玉子 牛 めし], 490),
                    Menu.new(%i[プレミアム おろし ポン酢 牛 めし], 480),
                    Menu.new(%i[味噌漬け トンテキ 牛 めし （国産玉ねぎ使用） + キムチ], 730),
                    Menu.new(%i[味噌漬け トンテキ 牛 めし （国産玉ねぎ使用） + 生野菜 + キムチ], 830),
                    Menu.new(%i[味噌漬け トンテキ 牛 めし （国産玉ねぎ使用） + とろろ], 730),
                    Menu.new(%i[味噌漬け トンテキ 牛 めし （国産玉ねぎ使用） + 生野菜 + とろろ], 830),
                    Menu.new(%i[創業 牛 カレー], 490), # 創業ビーフカレー
                    Menu.new(%i[創業 牛 カレー + 生野菜], 590),
                    Menu.new(%i[創業 プレミアム 牛 カレー 牛], 720),
                    Menu.new(%i[創業 牛 カレー 牛], 660),
                    Menu.new(%i[創業 ハンバーグ 牛 カレー], 720),
                    Menu.new(%i[味噌漬け トンテキ 丼 + キムチ], 730),
                    Menu.new(%i[味噌漬け トンテキ 丼 + とろろ], 730),
                    Menu.new(%i[味噌漬け トンテキ 丼 + 生野菜 + キムチ], 830),
                    Menu.new(%i[味噌漬け トンテキ 丼 + 生野菜 + とろろ], 830),
                    Menu.new(%i[豚 キムチ 丼], 650),
                    Menu.new(%i[キムチ カルビ 丼], 500),
                    Menu.new(%i[ネギ たっぷり ネギ 塩 豚 肩ロース 丼], 500),
                    Menu.new(%i[ビビンバ 丼], 500),
                    Menu.new(%i[まぐろ 丼 6枚盛], 730),
                    Menu.new(%i[まぐろ 丼 大漁12枚盛], 1000),
                    Menu.new(%i[海老 チリ ソース 定食], 730),
                    Menu.new(%i[海老 チリ ソース 定食 + ポテトサラダ], 790),
                    Menu.new(%i[豚 キムチ 定食], 730),
                    Menu.new(%i[牛 焼肉 定食], 600),
                    Menu.new(%i[カルビ 焼肉 定食], 660),
                    Menu.new(%i[豚 肩ロース 豚 焼肉定食], 600),
                    Menu.new(%i[豚 肩ロース 生姜焼 定食], 660),
                    Menu.new(%i[ブラウン ソース ハンバーグ 定食], 600),
                    Menu.new(%i[ブラウン ソース 玉子 ハンバーグ 定食], 680),
                    Menu.new(%i[プレミアム 牛 皿 + 牛 焼肉], 730),
                    Menu.new(%i[プレミアム 牛 皿 + 牛 焼肉 + 生野菜], 830),
                    Menu.new(%i[プレミアム 牛 皿 + 豚 焼肉], 730),
                    Menu.new(%i[プレミアム 牛 皿 + 豚 焼肉 + 生野菜], 830),
                    Menu.new(%i[プレミアム 牛 皿 + ブラウン ソース ハンバーグ], 730),
                    Menu.new(%i[プレミアム 牛 皿 + ブラウン ソース ハンバーグ + 生野菜], 830),
                    Menu.new(%i[プレミアム 牛 皿 + 焼鮭], 730),
                    Menu.new(%i[プレミアム 牛 皿 + 焼鮭 生野菜], 830),
                    Menu.new(%i[プレミアム 牛 皿 + カルビ 焼肉], 790),
                    Menu.new(%i[プレミアム 牛 皿 + カルビ 焼肉 + 生野菜], 890),
                    Menu.new(%i[プレミアム 牛 皿 + 豚 生姜焼], 790),
                    Menu.new(%i[プレミアム 牛 皿 + 豚 生姜焼 + 生野菜], 890),
                    Menu.new(%i[おこさま プレミアム 牛 めし プレート], 390),
                    Menu.new(%i[おこさま 牛 めし プレート], 390),
                    Menu.new(%i[おこさま カレー プレート], 390),
                    Menu.new(%i[+ おもちゃ], 200),
                    Menu.new(%i[りんご ジュース], 100),
                    Menu.new(%i[ぶっかけ うどん], 320),
                    Menu.new(%i[ぶっかけ うどん + ミニ プレミアム 牛 めし], 620),
                    Menu.new(%i[ぶっかけ うどん + ミニ 創業 カレー], 620),
                    Menu.new(%i[ぶっかけ とろろ 玉子 うどん], 400),
                    Menu.new(%i[ぶっかけ とろろ 玉子 うどん + ミニ プレミアム 牛 めし], 700),
                    Menu.new(%i[ぶっかけ とろろ 玉子 うどん + ミニ 創業 カレー], 700)])

  # 松屋の朝定食
  Morning = Set.new([%i[定番 朝 定食],
                     %i[焼鮭 定食],
                     %i[ソーセージ エッグ 定食]])

  # 松屋ネットワーク
  NetworkNode = Struct.new(:node, :follow) do
    def inspect
      "#<#{node}->(#{follow.inspect})>"
    end
  end

  class << self
    # 松屋ネットワークを構築し、始点を返す。
    # ==== Return
    # Matsuya::NetworkNode beginノード
    def network
      dic = { begin: NetworkNode.new(:begin, []) }
      Sample.each do |menu|
        [:begin, *menu.pattern, menu.price].each_cons(2) do |current, follow|
          node = dic[current] ||= NetworkNode.new(current, [])
          node.follow << if follow.is_a? Symbol
                           dic[follow] ||= NetworkNode.new(follow, [])
                         else
                           follow
                         end
        end
      end
      dic.values
    end

    # お客様に提供する商品を作る。私は接客は不得意なので、ランダムなものが出てくる。
    # おかの値が1に近づくほど狂った商品が出てくる。
    # ==== Args
    # [okano:]
    #   Float おかの値。おかの値が高いと商品が変異する確率が上がる。0-1の範囲の値。
    # [current:]
    #   Matsuya::NetworkNode 再帰呼出し用。省略する。
    # ==== Return
    # Array 材料を並べた配列
    def generate(okano: 0.1, current: network.find { |n| n.node == :begin })
      if current.is_a? NetworkNode
        nex = current.follow.sample
        if nex.is_a?(NetworkNode) && (rand < okano)
          [current.node, *generate(okano: okano, current: network.sample)]
        else
          [current.node, *generate(okano: okano, current: nex)]
        end
      end
    end

    # 材料を選択したら釜に入れてぐーるぐーる。
    # キムカル丼のように、『キムチ＋カルビ』がキムカルに変化するなど、松屋活用を考慮して
    # Matsuya.generate の戻り値を加工する
    # ==== Args
    # [dish] Array 現在の皿の状態
    # ==== Return
    # Array<String> できたー！どの特性を残そう？
    def preparation(dish)
      case dish
          in *head, :+, *tail
          [head, :'　', tail, :セット]
          in *head, :キムチ, :カルビ, *tail
          [head, :キムカル, tail]
          in *head, :創業, :牛, *tail
          [head, :創業ビーフ, tail]
          in *head, :創業, :プレミアム, :牛, *tail
          [head, :創業プレミアムビーフ, tail]
          in *head, :牛, :カレー, *tail
          [head, :ビーフカレー, tail]
          in *head, :ビビンバ, :丼, *tail
          [head, :ビビン丼, tail]
          in *head, :海老, :チリ, *tail
          [head, :海老のチリ, tail]
          in *head, :豚, :肩ロース, :豚, :焼肉定食, *tail
          [head, :豚, :肩ロース, :の, :豚, :焼肉定食, tail]
          in *head, :豚, :肩ロース, :生姜焼, :定食, *tail
          [head, :豚, :肩ロース, :の, :生姜焼, :定食, tail]
          in *head, :玉子, :ハンバーグ, *tail
          [head, :エッグ, :ハンバーグ, tail]
          in *head, :ネギ, :玉子, *tail
          [head, :ネギたま, tail]
          in *head, :とろろ, :玉子, *tail
          [head, :とろたま, tail]
          in *head, :カレー, :牛, *tail
          [head, :カレギュウ, tail]
          in *head, :ハンバーグ, :皿, *tail
          [head, :バーグディッシュ, tail]
          else
          dish
      end.flat_map do |node|
        if node.is_a? Array then preparation(node) else node end
      end
    end

    # 商品を注文し、商品を受け取る
    # ==== Args
    # [okano]
    #   Float おかの値。おかの値が高いと商品が変異する確率が上がる。0-1の範囲の値。
    # ==== Return
    # String 商品名
    def order(okano: 0.1)
      preparation(generate(okano: okano).reject { |x| x == :begin }).join
    end
  end
end
