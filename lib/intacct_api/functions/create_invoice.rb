module IntacctApi
  class CreateInvoice < Base
    attr_reader :intacct_object_id

    def initialize(intacct_object_id:)
      @intacct_object_id = intacct_object_id
      @intacct_object_name = 'create_invoice'.freeze
      @control_id = _control_id
    end

    def build_xml
      @xml = api_xml do |xml|
        IntacctApi::Function.new(xml_doc: xml, control_id: control_id).xml_block {
          xml.send(intacct_object_name) {
            xml.billid intacct_object_id
            yield xml
          }
        }
      end
    end
  end
