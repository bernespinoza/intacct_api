module IntacctApi
  class GetCustomer < Base
    attr_reader :intacct_key, :fields, :intacct_object_name

    def initialize(intacct_key: nil, fields:)
      @intacct_key = intacct_key
      @intacct_object_name = 'customer'.freeze
      @fields = fields.to_h
    end

    def build_xml
      @xml = api_xml do |xml|
        IntacctApi::Function.new(xml_doc: xml_doc, control_id: _control_id).xml_block {
          IntacctApi::Get.new(xml_doc: xml_doc, intacct_key: intacct_key,
            intacct_object: 'customer'.freeze).xml_block {
            xml_doc.fields {
              fields.each_pair do |field, value|
                xml_doc.send(field, value)
              end
            }
          }
        }
      end
    end
  end
end
