module IntacctApi
  class CreateCustomer < Base
    attr_reader :intacct_object_id

    def initialize(intacct_object_id:, name:)
      @intacct_object_id = intacct_object_id
      @intacct_object_name = 'customer'
      @control_id = _control_id
    end

    def build_xml
      @xml = api_xml do |xml|
        xml.function(controlid: '1'){
          xml.send("create_customer") {
            xml.customerid intacct_object_id
            yield xml
          }
        }
      end.doc.root.to_xml
    end
  end
end
