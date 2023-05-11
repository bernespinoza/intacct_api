module IntacctApi
  class GetCustomer < Base
    attr_reader :intacct_key

    def initialize(intacct_key: nil)
      @intacct_key = intacct_key
      @intacct_object_name = 'customer'
      @control_id = _control_id
    end

    def build_xml
      @xml = build_xml do |xml|
        xml.function(controlid: "f4") {
          xml.get(object: "customer", key: "#{intacct_key}") {
            xml.fields {
              yield xml
            }
          }
        }
      end.doc.root.to_xml
    end
  end
end