module IntacctApi
  class GetList < Base
    attr_reader :intacct_object_name, :filters, :filter,
      :expression, :limit

    def initialize(intacct_object_name:, filters:, sorts: nil, limit: 100)
      @intacct_object_name = intacct_object_name
      @filters = filters.to_h
      @limit = limit.to_i
    end

    def add_filter(filter)
      @expression = IntacctApi::Expression.new(field: filter[:field], value: filter[:value], operator: filter[:operator], xml_doc: xml_doc)
      @filter = IntacctApi::Filter.new(logicals: @logicals, xml_doc: xml_doc, expression: @expression)
    end

    def build_xml
      @xml = api_xml do |xml_doc|
        IntacctApi::Function.new(xml_doc: xml_doc, control_id: _control_id).xml_block do
          xml_doc.get_list(object: intacct_object_name, maxitems: limit) do
            build_filter(xml_doc)
            filter.build_xml
          end
        end
      end
    end

    private

      def build_filter(xml_doc)
        @logicals = filters.each_pair.map do |operator, expressions|
          logical = IntacctApi::Logical.new(operator: operator, xml_doc: xml_doc)
          expressions.each do |exp|
            expression = IntacctApi::Expression.new(field: exp[:field], value: exp[:value], operator: exp[:operator], xml_doc: xml_doc)
            logical.add_expression(expression)
          end
          logical
        end
        @filter = IntacctApi::Filter.new(logicals: @logicals, xml_doc: xml_doc)
      end

  end
end
