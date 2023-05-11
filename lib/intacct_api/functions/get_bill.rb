module IntacctApi
  class GetBill < Base
    attr_reader :intacct_key

    def initialize(intacct_key: nil)
      @intacct_key = intacct_key
      @intacct_object_name = 'bill'.freeze
      @control_id = _control_id
    end

    def build_xml
      @xml = api_xml do |xml|
        IntacctApi::Function.new(xml_doc: xml, control_id: control_id).xml_block {
          xml.get(object: intacct_object_name, key: intacct_key) {
            xml.fields {
              yield xml
            }
          }
        }
      end
    end

  end
end
