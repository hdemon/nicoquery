module NicoQuery
  module ObjectMapper
    class Description
      attr_reader :raw_text, :movie_references, :movie_references,
                  :community_references, :seiga_references

      def initialize(raw_text)
        @raw_text = raw_text.to_s
      end

      def text
        @raw_text
      end

      def movie_references
        # is this the high road?
        text.scan(/((sm|nm)\d{1,})/).map {|e| e[0]}
      end

      def mylist_references
        text.scan(/(?<=mylist\/)\d{1,}/).map(&:to_i)
      end

      def community_references
        text.scan(/co\d{1,}/)
      end

      def seiga_references
        text.scan(/im\d{1,}/)
      end
    end
  end
end
