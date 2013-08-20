require "nicoquery/object_mapper/mylist_rss"
require "nori"


module NicoQuery
  module ObjectMapper
    class TagSearchRss < MylistRSS
    end

    #   def title
    #     binding.pry
    #     @hash['title']
    #       .scan(/(?<=タグ\s).+(?=\‐ニコニコ動画)/)[0].split(' ')[0]
    #       # .force_encoding('utf-8')
    #   end
    # end
  end
end
# <?xml version="1.0" encoding="utf-8"?>
# <rss version="2.0"
#      xmlns:atom="http://www.w3.org/2005/Atom">

#   <channel>
#     <title>タグ VOICEROID+_東北ずん子‐ニコニコ動画</title>
#     <link>http://www.nicovideo.jp/tag/VOICEROID%2B_%E6%9D%B1%E5%8C%97%E3%81%9A%E3%82%93%E5%AD%90</link>
#     <atom:link rel="self" type="application/rss+xml" href="http://www.nicovideo.jp/tag/VOICEROID%2B_%E6%9D%B1%E5%8C%97%E3%81%9A%E3%82%93%E5%AD%90?rss=2.0"/>
#     <description>タグ「VOICEROID+_東北ずん子」が付けられた動画 (全 299 件)</description>
#     <pubDate>Sun, 18 Aug 2013 19:15:24 +0900</pubDate>
#     <lastBuildDate>Sun, 18 Aug 2013 19:15:24 +0900</lastBuildDate>
#     <generator>ニコニコ動画</generator>
#     <language>ja-jp</language>
#     <copyright>(c) niwango, inc. All rights reserved.</copyright>
#     <docs>http://blogs.law.harvard.edu/tech/rss</docs>

#     <item>
#       <title>【Minecraft】GREEN&#039;S CRAFT Part1【ゆっくり&amp;amp;VOICEROID+実況】</title>
#       <link>http://www.nicovideo.jp/watch/sm21615389</link>
#       <guid isPermaLink="false">tag:nicovideo.jp,2013-08-17:/watch/sm21615389</guid>
#       <pubDate>Sat, 17 Aug 2013 19:48:21 +0900</pubDate>
#       <description><![CDATA[
#       <p class="nico-thumbnail"><img alt="【Minecraft】GREEN&#039;S CRAFT Part1【ゆっくり&amp;amp;VOICEROID+実況】" src="http://tn-skr2.smilevideo.jp/smile?i=21615389" width="94" height="70" border="0"/></p>
#       <p class="nico-description">お久しぶりです。周りの人にも感化され、ようやく新シリーズに踏み込むことができました。勢いだけで始めてしまったため今後どうなるか自分でも予想できませんが前作同様ひっそりまったり、そして少しでも長く続けられるように頑張りますのでまたお付き合いいただけると嬉しいです（*´ヮ｀*）それでは、よろしくお願いします。使用MOD1.Opti Fine2.MinecraftIM3.PlayerFormLittleMaid4.Audiotori5.littleMaidMob6.Zabuton＋りばいあ製MOD×2次→まだシリーズまとめ→mylist/38367203まったりクラフター生活シリーズ→mylist/29017292他に作ったもの→mylist/29022355twitter⇒http://twitter.com/raichi_Jコミュco1590050『PHANTASY STAR ONLINE 2』公式サイトhttp://pso2.jp/</p>
#       <p class="nico-info"><small><strong class="nico-info-length">12:33</strong>｜<strong class="nico-info-date">2013年08月17日 19：48：21</strong> 投稿</small></p>
#       ]]></description>
#     </item>
#   </channel>

# </rss>
