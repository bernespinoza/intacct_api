module IntacctApi
  class CreateBill < Base
    attr_reader :intacct_object_id, :intacct_object_name, :bill_xml

    def initialize(bill)
      #@intacct_object_id = intacct_object_id
      @intacct_object_name = 'create_bill'.freeze
      @control_id = _control_id
      @bill_xml = bill.to_xml
    end

    def build_xml
      @xml = api_xml do |xml|
        IntacctApi::Function.new(xml_doc: xml, control_id: control_id).xml_block {
          xml.send(intacct_object_name) {
            bill_xml.call(xml)
          }
          xml
        }
      end
    end
  end
end
