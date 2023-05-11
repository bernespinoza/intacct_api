module IntacctApi
  class CreateVendor < Base
    attr_reader :intacct_object_id

    def initialize(intacct_object_id:)
      @intacct_object_id = intacct_object_id
      @intacct_object_name = 'vendor'
      @control_id = _control_id
    end

    def build_xml
      @xml = api_xml do |xml|
        xml.function(controlid: '1'){
          xml.send("create_customer") {
            xml.vendorid intacct_object_id
            yield xml
          }
        }
      end.doc.root.to_xml
    end

    def o
      @xml = api_xml do |xml|
        Function.new(xml_dock: xml, control_id: control_id).xml_block {
          xml.send("create_customer") {
            xml.vendor_id
            yield xml
          }
        }
      end
    end
  end
end
