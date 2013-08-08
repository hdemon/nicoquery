require 'nori'


module NicoQuery
  module Source
    module HashMapper
      def map_to_hash(xml)
        (Nori.new).parse xml
      end

      module_function :map_to_hash
    end
  end
end
