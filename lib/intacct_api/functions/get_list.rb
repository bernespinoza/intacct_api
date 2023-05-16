module IntacctApi
  class GetList < Base
    attr_reader :intacct_object_name, :filters, :xml_doc, :filter, :expression, :xml_doc

    def initialize(xml_doc:, intacct_object_name:, filters:, sorts: nil)
      #sorts.respond_to?(:build_xml)
      #filter.respond_to?(:build_xml)
      @intacct_object_name = intacct_object_name
      #@filters = { 'and': {field: 'field', value: 's', operator: ''}}
      @filters = filters
      @xml_doc = xml_doc
      @logicals = @filters.each_pair.map do |k,v|
        logical = IntacctApi::Logical.new(operator: k, xml_doc: xml_doc)
        v.each do |e|
          expression = IntacctApi::Expression.new(field: e[:field], value: e[:value], operator: e[:operator], xml_doc: xml_doc)
          logical.add_expression(expression)
        end
        logical
      end

      @filter = IntacctApi::Filter.new(logicals: @logicals, xml_doc: xml_doc)
    end

    def add_filter(filter)
      @expression = IntacctApi::Expression.new(field: filter[:field], value: filter[:value], operator: filter[:operator], xml_doc: xml_doc)
      @filter = IntacctApi::Filter.new(logicals: @logicals, xml_doc: xml_doc, expression: @expression)
    end

    def build_xml
      @xml = api_xml do |xml_doc|
        IntacctApi::Function.new(xml_doc: xml_doc, control_id: control_id).xml_block do
          xml_doc.get_list(object: intacct_object_name) do
            filter.build_xml
          end
        end
      end
    end

  end
end
