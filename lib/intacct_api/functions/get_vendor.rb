module IntacctApi
  class GetVendor < Base
    attr_reader :intacct_key

    def initialize(intacct_key:)
      @intacct_key = intacct_key
      @intacct_object_name = 'vendor'
      @control_id = _control_id
    end

    def build_xml
      @xml = api_xml do |xml|
        xml.function(controlid: control_id) {
          xml.get(object: intacct_object_name, key: intacct_key) {
            xml.fields {
              yield xml
            }
          }
        }
      end.doc.root.to_xml
    end

  end
end
