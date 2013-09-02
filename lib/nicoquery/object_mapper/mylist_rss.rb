require "nori"


module NicoQuery
  module ObjectMapper
    class MylistRSS
      attr_reader :meta, :items

      def initialize(xml)
        parser = Nori.new
        parsed_xml = parser.parse xml
        entire = parsed_xml['rss']['channel']

        @meta = Meta.new entire, title_prefix
        if entire['item'].is_a? Array
          @items = entire['item'].map { |item| Item.new item }
        elsif entire['item'].nil?
          @items = []
        else
        # noriは子要素が複数の場合は配列に変換するが、1つの場合には配列にしない。
        # しかし、MylistRSSはitemsが配列であること前提にしているので、item要素が
        # 1つだけの場合にも配列に変換する必要がある。
          @items = [ Item.new(entire['item']) ]
        end
      end

      def title_prefix
        "マイリスト"
      end

      class Meta
        def initialize(parsed_xml, title_prefix)
          @title_prefix = title_prefix
          @hash = parsed_xml
        end

        def title
          @hash['title']
            .scan(/(?<=#{@title_prefix}\s).+(?=\‐ニコニコ動画)/)[0].split(' ')[0]
            # .force_encoding('utf-8')
        end

        def url
          link
        end

        def link
          @hash['link']
        end

        def mylist_id
          @hash['link'].scan(/(?<=mylist\/)\d{1,}/)[0].to_i
        end

        def description
          @hash['description']
        end

        def publish_date
          Time.parse @hash['publish_date']
        end

        def last_build_date
          Time.parse @hash['lastBuildDate']
        end

        def creator
          @hash['dc:creator']
        end
      end

      class Item
        def initialize(parsed_xml)
          @hash = parsed_xml
        end

        def title
          @hash['title']
        end

        def video_id
          (url.scan(/((sm|nm)\d{1,})/).map {|e| e[0]})[0]
        end

        def url
          @hash['link']
        end

        def thread_id
          @hash['guid'].scan(/(?<=watch\/)\d{1,}$/)[0].to_i
        end

        def publish_date
          Time.parse @hash['pubDate']
        end

        def thumbnail_url
          description.raw_text.scan(/(?<=src\=\").{1,}(?=\"\swidth)/)[0]
          $&
        end

        def view_counter
          description.raw_text.scan(/(?<=nico-numbers-view\">)[0-9,]{1,}(?=\<\/strong)/)[0].delete(',').to_i
        end

        def comment_num
          description.raw_text.scan(/(?<=nico-numbers-res\">)[0-9,]{1,}(?=\<\/strong)/)[0].delete(',').to_i
        end

        def mylist_counter
          description.raw_text.scan(/(?<=nico-numbers-mylist\">)[0-9,]{1,}(?=\<\/strong)/)[0].delete(',').to_i
        end

        def description
          @_description ||= Description.new @hash['description']
        end

        def length
          description.raw_text.scan(/(?<=class\=\"nico\-info\-length\"\>)\d{1,}\:\d{1,2}(?=\<\/strong\>)/)
          length_string = $&.to_s.split(':')
          length_string[0].to_i * 60 + length_string[1].to_i
        end

        class Description
          attr_reader :raw_text

          def initialize(raw_text)
            @raw_text = raw_text.to_s
          end

          def text
            @raw_text.scan /(?<=class\=\"nico\-description\"\>).{1,}(?=\<\/p\>)/
            $&
          end

          def movie_references
            # is this the high road?
            text.scan(/((sm|nm)\d{1,})/).map {|e| e[0]}
          end

          def mylist_references
            text.scan(/(?<=mylist\/)\d{1,}/).map(&:to_i)
          end

          def community_references
            text.scan /co\d{1,}/
          end

          def seiga_references
            text.scan /im\d{1,}/
          end
        end
      end

      # <?xml version="1.0" encoding="utf-8"?>
      # <rss version="2.0"
      #      xmlns:dc="http://purl.org/dc/elements/1.1/"
      #      xmlns:atom="http://www.w3.org/2005/Atom">

      #   <channel>

      #     <title>マイリスト to_test‐ニコニコ動画</title>
      #     <link>http://www.nicovideo.jp/mylist/38369702</link>
      #     <atom:link rel="self" type="application/rss+xml" href="http://www.nicovideo.jp/mylist/38369702?rss=2.0"/>
      #     <description></description>
      #     <pubDate>Sat, 17 Aug 2013 22:51:40 +0900</pubDate>
      #     <lastBuildDate>Sat, 17 Aug 2013 22:51:40 +0900</lastBuildDate>
      #     <generator>ニコニコ動画</generator>
      #     <dc:creator>うえおに</dc:creator>
      #     <language>ja-jp</language>
      #     <copyright>(c) niwango, inc. All rights reserved.</copyright>
      #     <docs>http://blogs.law.harvard.edu/tech/rss</docs>


      #     <item>
      #       <title>【初音ミク】みくみくにしてあげる♪【してやんよ】</title>
      #       <link>http://www.nicovideo.jp/watch/sm1097445</link>
      #       <guid isPermaLink="false">tag:nicovideo.jp,2007-09-20:/watch/1190218917</guid>
      #       <pubDate>Sat, 17 Aug 2013 22:54:20 +0900</pubDate>
      #       <description><![CDATA[<p class="nico-thumbnail"><img alt="【初音ミク】みくみくにしてあげる♪【してやんよ】" src="http://tn-skr2.smilevideo.jp/smile?i=1097445" width="94" height="70" border="0"/></p><p class="nico-description">おまえら、みっくみくにしてやんよ。歌詞はhttp://ikamo.hp.infoseek.co.jp/mikumiku.txt（9/20 1:55修正）。上げている他のもの→mylist/1450136</p><p class="nico-info"><small><strong class="nico-info-length">1:38</strong>｜<strong class="nico-info-date">2007年09月20日 01：22：02</strong> 投稿</small></p>]]></description>
      #     </item>

      #     <item>
      #       <title>新・豪血寺一族 -煩悩解放 - レッツゴー！陰陽師</title>
      #       <link>http://www.nicovideo.jp/watch/sm9</link>
      #       <guid isPermaLink="false">tag:nicovideo.jp,2007-03-06:/watch/1173108780</guid>
      #       <pubDate>Sat, 17 Aug 2013 22:52:21 +0900</pubDate>
      #       <description><![CDATA[<p class="nico-thumbnail"><img alt="新・豪血寺一族 -煩悩解放 - レッツゴー！陰陽師" src="http://tn-skr2.smilevideo.jp/smile?i=9" width="94" height="70" border="0"/></p><p class="nico-description">レッツゴー！陰陽師（フルコーラスバージョン）</p><p class="nico-info"><small><strong class="nico-info-length">5:19</strong>｜<strong class="nico-info-date">2007年03月06日 00：33：00</strong> 投稿</small></p>]]></description>
      #     </item>

      #   </channel>

      # </rss>
    end
  end
end
