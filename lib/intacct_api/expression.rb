module IntacctApi
  class Expression
    OPERATORS = {
      '=': '=',
      '!=': '!=',
      '<': '&lt',
      '<=': '&lt;=',
      '>': '&gt;',
      '>=': '&gt;=',
      is_null: 'is null'
    }
    attr_reader :xml_doc, :operator, :value, :field

    def initialize(field:, operator:, value:, xml_doc:)
      @operator = OPERATORS[operator.to_sym]
      @field = field
      @value = value
      @xml_doc = xml_doc
    end

    def build_xml
      xml_doc.expression {
        xml_doc.field field
        xml_doc.operator operator
        xml_doc.value value
      }
    end

  end
end
