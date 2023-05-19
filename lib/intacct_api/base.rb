module IntacctApi
  class Base
    attr_reader :response, :xml, :intacct_object_name, :control_id

    def send_xml(xml=nil)
      xml_doc = xml || @xml

      @response = IntacctApi::Response.
        new(
          request_xml: xml_doc,
          response_xml: call_intacct_api(xml_to_s(xml_doc))
        )
    end

    private

      def api_xml
        @request_xml = Nokogiri::XML::Builder.new do |xml|
          xml.request {

            IntacctApi::Control.new(xml_doc: xml).to_xml

            IntacctApi::Operation.new(xml_doc: xml).xml_block {

              IntacctApi::Authentication.new(xml_doc: xml).to_xml

              IntacctApi::Content.new(xml_doc: xml).xml_block {
                yield xml
              }

            }
          }
        end
      end

      def _control_id
        "#{intacct_object_name}_#{Time.now.to_i}"
      end

      def xml_to_s(xml)
        xml.to_xml
      end

    protected

      def call_intacct_api(xml_string)
        Net::HTTP.post_form(service_uri,
          'xmlrequest' => xml_string
        ).body
      end

      def service_uri
        url = Intacct.service_url || "https://www.intacct.com/ia/xml/xmlgw.phtml"
        URI(url)
      end


  end
end
