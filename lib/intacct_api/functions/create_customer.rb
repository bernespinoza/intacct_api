module IntacctApi
  class CreateCustomer < Base
    attr_reader :intacct_object_id, :fields

    def initialize(intacct_object_id:, fields:)
      @intacct_object_id = intacct_object_id
      @intacct_object_name = 'create_customer'.freeze
      @fields = fields.to_h
      @control_id = _control_id
    end

    def build_xml
      @xml = api_xml do |xml|
        IntacctApi::Function.new(xml_doc: xml, control_id: control_id).xml_block {
          xml.send(intacct_object_name) {
            xml.customerid intacct_object_id
            fields.each_pair do |field, value|
              xml.send(field, value)
            end
          }
        }
      end
    end
  end
end
