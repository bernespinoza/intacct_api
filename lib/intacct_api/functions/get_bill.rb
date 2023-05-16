module IntacctApi
  class GetBill < Base
    attr_reader :intacct_key

    def initialize(intacct_key: nil)
      @intacct_key = intacct_key
      @intacct_object_name = 'bill'.freeze
      @control_id = _control_id
    end

    def build_xml
      @xml = api_xml do |xml_doc|
        IntacctApi::Function.new(xml_doc: xml_doc, control_id: control_id).xml_block {
          xml_doc.get(object: intacct_object_name, key: intacct_key) {
            xml_doc.fields {
              yield xml_doc
            }
          }
        }
      end
    end

  end
end
