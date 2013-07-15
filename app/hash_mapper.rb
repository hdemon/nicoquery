require 'nori'


module NicoAPI
  module HashMapper
    def map_to_hash(xml)
      parser = Nori.new
      parser.parse xml
    end

    module_function :map_to_hash
  end
end
