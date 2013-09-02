module Fixture
  def self.tag_search_rss_403
    """
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0"
     xmlns:dc="http://purl.org/dc/elements/1.1/"
     xmlns:atom="http://www.w3.org/2005/Atom">

  <channel>

    <title>マイリスト‐ニコニコ動画</title>
    <link>http://www.nicovideo.jp/</link>
    <atom:link rel="self" type="application/rss+xml" href="http://www.nicovideo.jp/mylist/38350049?rss=2.0"/>
    <description>このマイリストは非公開に設定されています。</description>
    <generator>ニコニコ動画</generator>
    <language>ja-jp</language>
    <copyright>(c) niwango, inc. All rights reserved.</copyright>
    <docs>http://blogs.law.harvard.edu/tech/rss</docs>


  </channel>

</rss>
    """
  end
end

