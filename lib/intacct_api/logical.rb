module IntacctApi
  class Logical
    Operators = {
      or: 'or',
      and: 'and'
    }

    attr_reader :operator, :xml_doc, :expressions, :logicals

    def initialize(operator:, xml_doc:,  expressions: [])
      @operator = Operators[operator.to_sym]
      @expressions = expressions
      @xml_doc = xml_doc
    end

    def add_expression(expression)
      @expressions << expression
    end

    def build_xml
      xml_doc.logical(logical_operator: operator) do
        expressions.each do |expression|
          expression.build_xml
        end
      end
    end


  end
end
