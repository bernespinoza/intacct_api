module IntacctApi
  class Filter
    attr_reader :logicals

    def initialize(logicals:, :expresion)
      @logicals = logicals
      @expresion = expresion
    end

    def build_xml
      xml_doc.filter {
        @logicals.each do |logical|
          logicial.build_xml
        end

        unless expresion.nil?
          expresion.build_xml
        end
      }
    end
  end
end
