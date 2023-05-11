module IntacctApi
  class Operation
    attr_reader :xml_doc, :transaction

    def initialize(xml_doc:, transaction: false)
      @xml_doc = xml_doc
      @transaction = transaction
    end

    def xml_block
      xml_doc.operation(transaction: transaction) {
        yield xml_doc
      }
    end
  end
end
