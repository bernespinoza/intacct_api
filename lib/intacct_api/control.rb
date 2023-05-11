module IntacctApi
  class Control
    attr_reader :xml_doc, :unique_id, :control_id

    def initialize(xml_doc: )
      @xml_doc = xml_doc
      @unique_id = false
      @control_id = _control_id
    end

    def to_xml
      xml_doc.control {
        xml_doc.senderid IntacctApi.xml_sender_id
        xml_doc.password IntacctApi.xml_password
        xml_doc.controlid control_id
        xml_doc.uniqueid unique_id
        xml_doc.dtdversion IntacctApi.version
      }
    end

    private
      def _control_id
        "c_#{Time.now.to_i}"
      end

  end
end
