# -*- coding: utf-8 -*-
require "matsuya/version"
require 'egison'
require 'set'

module Matsuya
  # 松屋の商品。価格は、牛めしなら並盛など、標準の量と思われるものを入れておく
  Menu = Struct.new(:pattern, :price)

  # 松屋に実際にあるメニュー。
  # 牛めしのようにプレミアムとそうでないものがある場合は、プレミアムだけを書く
  # オリジナルカレギュウ（プレミアム牛肉使用）も、プレミアムとして扱い、プレミアム牛肉使用と書いていないほうは書かない
  Sample = Set.new([ Menu.new(%i[プレミアム 牛 めし], 380),
                     Menu.new(%i[プレミアム 旨 辛 ネギ たま 牛 めし], 480),
                     Menu.new(%i[プレミアム おろし ポン酢 牛 めし], 480),
                     Menu.new(%i[プレミアム キムチ 牛 めし], 480),
                     Menu.new(%i[プレミアム 牛 とじ 丼], 550),
                     Menu.new(%i[オリジナル カレー], 330),
                     Menu.new(%i[オリジナル カレギュウ （プレミアム牛肉使用）], 500),
                     Menu.new(%i[オリジナル カレギュウ], 490),
                     Menu.new(%i[オリジナル ハンバーグ カレー], 590),
                     Menu.new(%i[ネギ たっぷり ネギ 塩 豚 カルビ 丼], 450),
                     Menu.new(%i[ビビンバ 丼], 450),
                     Menu.new(%i[キムチ カルビ 丼], 490),
                     Menu.new(%i[豚 テキ 定食], 690),
                     Menu.new(%i[シャンピニオン ソース ハンバーグ 定食], 650),
                     Menu.new(%i[牛 焼肉 定食], 590),
                     Menu.new(%i[カルビ 焼肉 定食], 630),
                     Menu.new(%i[豚 バラ 焼肉 定食], 550),
                     Menu.new(%i[スタミナ 豚 バラ 生姜焼 定食], 590),
                     Menu.new(%i[鶏 チリ ソース 定食], 630),
                     Menu.new(%i[ブラウン ソース ハンバーグ 定食], 630),
                     Menu.new(%i[豆腐 キムチ チゲ 膳 （プレミアム牛肉使用）], 530),
                     Menu.new(%i[チゲ カルビ 焼肉 膳 （プレミアム牛肉使用）], 720),
                     # 鉄皿メニュー
                     Menu.new(%i[鉄皿 鶏 グリル セット], 640),
                     Menu.new(%i[鉄皿 ブラウン ソース ハンバーグ セット], 520),
                     Menu.new(%i[鉄皿 旨 トマト ハンバーグ セット], 520), # 鉄皿 うま トマ ハンバーグ セット
                     # うどん
                     Menu.new(%i[肉 カレー うどん ], 450),
                     Menu.new(%i[肉 カレー うどん + 牛 めし], 680),
                     Menu.new(%i[肉 カレー うどん + ライス], 520),
                     Menu.new(%i[ミニ カレー うどん], 200),
                     Menu.new(%i[肉 カレー うどん （プレミアム牛肉使用）], 450),
                     Menu.new(%i[肉 カレー うどん （プレミアム牛肉使用） + プレミアム 牛 めし], 770),
                     Menu.new(%i[肉 カレー うどん  （プレミアム牛肉使用） + ライス], 520),
                     Menu.new(%i[担々 うどん （関西風だし）], 450),
                     Menu.new(%i[担々 うどん （関西風だし） + 牛 めし], 680),
                     Menu.new(%i[担々 うどん], 450),
                     Menu.new(%i[担々 うどん + プレミアム 牛 めし], 770),
                     Menu.new(%i[とろ たま うどん （関西風だし）], 410),
                     Menu.new(%i[とろ たま うどん （関西風だし） + 牛 めし], 640),
                     Menu.new(%i[とろ たま うどん], 410),
                     Menu.new(%i[とろ たま うどん + プレミアム 牛 めし], 730),
                     Menu.new(%i[きつね うどん （関西風だし）], 390),
                     Menu.new(%i[きつね うどん （関西風だし） + 牛 めし], 620),
                     Menu.new(%i[きつね うどん], 390),
                     Menu.new(%i[きつね うどん + プレミアム 牛 めし], 710),
                     Menu.new(%i[ミニ うどん （関西風だし）], 180),
                     Menu.new(%i[ミニ うどん], 180),
                   ])

  # 松屋の朝定食
  Morning = Set.new([ %i[定番 朝 定食],
                      %i[焼鮭 定食],
                      %i[ソーセージ エッグ 定食]])

  # 松屋ネットワーク
  NetworkNode = Struct.new(:node, :follow) do
    def inspect
      "#<#{node}->(#{follow.inspect})>"
    end
  end

  class << self
    # こんなことに使われるなんて可哀想なライブラリだな
    include Egison

    # 松屋ネットワークを構築し、始点を返す。
    # ==== Return
    # Matsuya::NetworkNode beginノード
    def network
      dic = {begin: NetworkNode.new(:begin, [])}
      Sample.each do |menu|
        [:begin, *menu.pattern, menu.price].each_cons(2) do |current, follow|
          node = dic[current] ||= NetworkNode.new(current, [])
          if follow.is_a? Symbol
            node.follow << dic[follow] ||= NetworkNode.new(follow, [])
          else
            node.follow << follow
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
    def generate(okano: 0.1, current: network.find{|n|n.node == :begin})
      if current.is_a? NetworkNode
        nex = current.follow.sample
        if nex.is_a?(NetworkNode) and rand < okano
          [current.node, *generate(okano: okano, current: network.sample)]
        else
          [current.node, *generate(okano: okano, current: nex)]
        end
      end
    end

    # 材料を選択したら釜に入れてぐーるぐーる。
    # キムカル丼のように、『キムチ＋カルビ』がキムカルに変化するなど、松屋活用を考慮して
    # Matsuya.generate の戻り値をStringに変換する
    # ==== Args
    # [dish] Array 現在の皿の状態
    # ==== Return
    # String できたー！どの特性を残そう？
    def preparation(dish)
      match(dish) do
        with(Egison::List.(*_head, :+, *_tail)) do
          if tail.last == :セット
            [head, :'　', :ミニ, tail]
          else
            [head, :'　', :ミニ, tail, :セット]
          end
        end

        with(Egison::List.(*_head, :キムチ, :カルビ, *_tail)) do
          [head, :キムカル, tail]
        end

        with(Egison::List.(*_head, :ビビンバ, :丼, *_tail)) do
          [head, :ビビン丼, tail]
        end

        with(Egison::List.(*_head, :鶏, :チリ, *_tail)) do
          [head, :鶏のチリ, tail]
        end

        with(Egison::List.(*_head, :カルビ, :焼肉, *_tail)) do
          [head, :カルビ焼, tail]
        end

        with(Egison::List.(*_head, :旨, :トマト, *_tail)) do
          [head, :うまトマ, tail]
        end

        with(Egison::List.(*_head, :鶏, :グリル, *_tail)) do
          [head, :チキン, :グリル, tail]
        end

        with(Egison::List.(*_head, :プレミアム, *_center, :（プレミアム牛肉使用）, *_tail)) do
          [head, :プレミアム, center + tail]
        end

        with(Egison::List.(*_head, :牛, :めし, *_center, :（プレミアム牛肉使用）, *_tail)) do
          [:プレミアム, head, :牛, :めし, center + tail]
        end

        with(Egison::Multiset.(*_not_match)) do
          not_match
        end
      end
        .map{|node| if node.is_a? Array then preparation(node) else node end }
        .flatten
    end

    # 商品を注文し、商品を受け取る
    # ==== Args
    # [okano]
    #   Float おかの値。おかの値が高いと商品が変異する確率が上がる。0-1の範囲の値。
    # ==== Return
    # String 商品名
    def order(okano=0.1) # !> shadowing outer local variable - ys2
      preparation(generate.reject{|x|x==:begin}).join
    end
  end
end
