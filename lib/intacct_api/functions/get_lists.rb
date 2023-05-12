module IntacctApi
  class GetList
    attr_reader :intacct_object_name, :filter, :xml_doc

    def initialize(xml_doc:, intacct_obejct_name:, filter:, sort: nil)
      #sorts.respond_to?(:build_xml)
      filters.respond_to?(:build_xml)
      @xml_doc = xml_doc
      @intacct_object_name = intacct_object_name
      @filter = filter
    end

    def build_xml
      IntacctApi::Function.new(xml_doc: xml_doc, control_id: control_id).xml_block{
        xml.get_list(object: intacct_object_name) do
          filter.build_xml
        end
      }
    end

  end
end
