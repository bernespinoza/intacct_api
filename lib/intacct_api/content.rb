module IntacctApi
  class Content
    attr_reader :xml_doc

    def initialize(xml_doc:)
      @xml_doc = xml_doc
    end

    def xml_block
      xml_doc.content {
        yield xml_doc
      }
    end
  end
end
