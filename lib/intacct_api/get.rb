module IntacctApi
  class Get
    attr_reader :intacct_key, :intacct_object, :xml_doc

    def initialize(intacct_key:, intacct_object:, xml_doc:)
      @intacct_key =  intacct_key.to_s
      @intacct_object = intacct_object.to_s
      @xml_doc = xml_doc
    end

    def xml_block
      xml_doc.get(object: intacct_object, key: intacct_key) {
        yield xml_doc
      }

    end
  end
end
