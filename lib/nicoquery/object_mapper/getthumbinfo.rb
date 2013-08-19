require "nori"


module NicoQuery
  module ObjectMapper
    class GetThumbInfo
      def initialize(xml)
        @xml = xml
        parser = Nori.new
        parsed_xml = parser.parse xml
        @hash = parsed_xml['nicovideo_thumb_response']['thumb']
      end

      def video_id
        @hash['video_id']
      end

      def title
        @hash['title']
      end

      def description
        @hash['description']
      end

      def thumbnail_url
        @hash['thumbnail_url']
      end

      def first_retrieve
        @hash['first_retrieve'].to_time
      end

      def publish_date # alias
        first_retrieve
      end

      def length
        string = @hash['length'].split(':')
        string[0].to_i * 60 + string[1].to_i
      end

      def movie_type
        @hash['movie_type']
      end

      def size_high
        @hash['size_high'].to_i
      end

      def size_low
        @hash['size_low'].to_i
      end

      def view_counter
        @hash['view_counter'].to_i
      end

      def comment_num
        @hash['comment_num'].to_i
      end

      def mylist_counter
        @hash['mylist_counter'].to_i
      end

      def last_res_body
        @hash['last_res_body']
      end

      def url
        @hash['watch_url']
      end

      def watch_url
        @hash['watch_url']
      end

      def thumb_type
        @hash['thumb_type']
      end

      def embeddable
        @hash['embeddable'] == 1
      end

      def no_live_play
        @hash['no_live_play'] == 1
      end

      def tags
        xml = @xml.scan(/\<tags domain=\"jp\">\n.+\n\<\/tags\>/m)[0]
        parsed = Nokogiri::XML xml
        parsed.xpath("//tag").map do |tag_object| 
          generate_tag_hash_by tag_object
        end
      end

      def user_id
        @hash['user_id'].to_i
      end

      def generate_tag_hash_by(nokogiri_xml)
        text = nokogiri_xml.text

        lock = if nokogiri_xml.attributes['lock'].present?
          nokogiri_xml.attributes['lock'].text.to_i == 1
        else
          false
        end

        { text: text, lock: lock }
      end
    end
  end
end

# <nicovideo_thumb_response status="ok">
#   <thumb>
#     <video_id>sm9</video_id>
#     <title>新・豪血寺一族 -煩悩解放 - レッツゴー！陰陽師</title>
#     <description>レッツゴー！陰陽師（フルコーラスバージョン）</description>
#     <thumbnail_url>http://tn-skr2.smilevideo.jp/smile?i=9</thumbnail_url>
#     <first_retrieve>2007-03-06T00:33:00+09:00</first_retrieve>
#     <length>5:19</length>
#     <movie_type>flv</movie_type>
#     <size_high>21138631</size_high>
#     <size_low>17436492</size_low>
#     <view_counter>13536149</view_counter>
#     <comment_num>4148196</comment_num>
#     <mylist_counter>133688</mylist_counter>
#     <last_res_body>へん? はははははははははは wwwwwwwwwwwwwwwwwwww ...</last_res_body>
#     <watch_url>http://www.nicovideo.jp/watch/sm9</watch_url>
#     <thumb_type>video</thumb_type>
#     <embeddable>1</embeddable>
#     <no_live_play>0</no_live_play>
#     <tags domain="jp">
#       <tag lock="1">陰陽師</tag>
#       <tag lock="1">レッツゴー！陰陽師</tag>
#       <tag lock="1">公式</tag>
#       <tag lock="1">音楽</tag>
#       <tag lock="1">ゲーム</tag>
#       <tag>β時代の英雄</tag>
#       <tag>運営のお気に入り</tag>
#       <tag>最古の動画</tag>
#       <tag>1000万再生</tag>
#       <tag>弾幕動画</tag>
#     </tags>
#     <user_id>4</user_id>
#   </thumb>
# </nicovideo_thumb_response>