module IntacctApi
  class Control
    attr_reader :xml_doc, :unique_id

    def initialize(xml_doc: )
      @xml_doc = xml_doc
      @unique_id = false
    end

    def to_xml
      xml_doc.control {
        xml_doc.senderid IntacctApi.xml_sender_id
        xml_doc.password IntacctApi.xml_password
        xml_doc.controlid "INVOICE XML"
        xml_doc.controlid control_id
        xml_doc.uniqueid unique_id
        xml_doc.dtdversion IntacctApi.version
      }
    end

    private
      def control_id
        'INVOICE XML'
        # create better control id
      end
  end
end
