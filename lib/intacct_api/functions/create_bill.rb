module IntacctApi
  class CreateBill < Base
    attr_reader :intacct_object_id, :intacct_object_name, :bill_xml, :bill

    def initialize(bill)
      @bill = bill
      @intacct_object_name = 'create_bill'.freeze
      @control_id = _control_id
      @bill_xml = bill.to_xml
    end

    def build_xml
      @xml = api_xml do |xml_doc|
        IntacctApi::Function.new(xml_doc: xml_doc, control_id: control_id).xml_block do
          xml.send(intacct_object_name) do
            if block_given?
              yield xml, bill
            else
              bill_xml.call(xml)
            end
          end
          #  Returns the doc because xml.send method is returning itself
          xml_doc
        end
      end
    end
  end
end
