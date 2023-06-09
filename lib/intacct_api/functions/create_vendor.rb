module IntacctApi
  class CreateVendor < Base
    attr_reader :vendor_id, :vendor_data

    def initialize(vendor_id:, vendor_data: {})
      @vendor_data = vendor_data
      @intacct_object_id = intacct_object_id
      @intacct_object_name = 'create_vendor'.freeze
      @control_id = _control_id
      @vendor = ::Vendor.new(vendor_data)
    end

    def build_xml
      @xml = api_xml do |xml_doc|
        IntacctApi::Function.new(xml_doc: xml, control_id: control_id).xml_block do
          xml.send(intacct_object_name) do
            xml.vendorid intacct_object_id
            if block_given?
              yield vendor
              vendor.to_xml(xml)
            else
              vendor.to_xml(xml)
            end
          end
        end
      end
    end
  end
end
