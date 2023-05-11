module IntacctApi
  class Function
    attr_reader :xml_doc, :control_id

    def initialize(xml_doc:, control_id:)
      @xml_doc = xml_doc
      @control_id = control_id
    end

    def xml_block
      xml_doc.function(control_id: control_id){
        yield xml_doc
      }
    end

  end
end
