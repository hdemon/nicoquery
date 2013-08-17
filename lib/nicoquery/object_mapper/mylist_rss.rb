module NicoQuery
  module ObjectMapper
    module MylistRSS
      class Meta
        # include TagParser

        def parse(xml)
          @xml = xml
          @title  = title
          @link = link
          @description = description
          @publish_date = publish_date
          @last_build_date = last_build_date
          @creator = creator

          self
        end

        def title
          inner_text(tag: 'title', xml: @xml)
            .scan(/(?<=マイリスト\s).+(?=\‐ニコニコ動画)/)[0].split(' ')[0]
        end

        def link
          inner_text tag: 'link', xml: @xml
        end

        def description
          inner_text tag: 'description', xml: @xml
        end

        def publish_date
          Time.parse inner_text(tag: 'pubDate', xml: @xml)
        end

        def last_build_date
          Time.parse inner_text(tag: 'lastBuildDate', xml: @xml)
        end

        def creator
          inner_text(tag: 'dc:creator', xml: @xml)
        end

        private

        def inner_text(tag: tag, xml: xml)
          xml.scan(/(?<=\<#{tag}\>).+(?=\<\/#{tag}\>)/)[0]
        end
      end
    end
  end
end
