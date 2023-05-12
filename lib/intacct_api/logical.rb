module IntacctApi
  class Logical
    Operators = {
      or: 'or',
      and: 'and'
    }

    def initialize(operator:, expresions: [])
      @operator = Operators[operator]
      @expresions = expresions
      @logicals = []
    end

    def add_expresion(expresion)
      expresions << expresion
    end

    def add_logical(logical)
      logicals << logical
    end

    def build_xml
      xml_doc.logical(logical_operator: operator) do
        logicals.each do |logical|
          logical.build_xml
        end
        expresions.each do |expresion|
          expresion.build_xml
        end
      end
    end


  end
end
