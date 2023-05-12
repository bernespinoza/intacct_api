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

    def initialize(field:, operator:, value:)
      @operator = OPERATORS[operator]
      @field = field
      @value = value
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
