module IntacctApi
  class Filter
    attr_reader :xml_doc, :logicals, :expression

    def initialize(logicals:, xml_doc:,  expression: nil)
      @logicals = logicals
      @expression = expression
      @xml_doc = xml_doc
    end

    def build_xml
      xml_doc.filter do
        @logicals.each do |logical|
          logical.build_xml
        end

        unless expression.nil?
          expression.build_xml
        end
      end
    end

  end
end
