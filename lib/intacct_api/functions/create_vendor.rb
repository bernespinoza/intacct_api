module IntacctApi
  class CreateVendor < Base
    attr_reader :intacct_object_id

    def initialize(intacct_object_id:)
      @intacct_object_id = intacct_object_id
      @intacct_object_name = 'create_vendor'.freeze
      @control_id = _control_id
    end

    def build_xml
      @xml = api_xml do |xml|
        IntacctApi::Function.new(xml_doc: xml, control_id: control_id).xml_block {
          xml.send(intacct_object_name) {
            xml.vendorid intacct_object_id
            yield xml
          }
        }
      end
    end
  end
end
