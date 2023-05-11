module IntacctApi
  class Base
    attr_reader :request_xml, :response, :xml, :intacct_object_name, :control_id

    def send_xml(xml=nil)
      url = Intacct.service_url || "https://www.intacct.com/ia/xml/xmlgw.phtml"
      uri = URI(url)
      xml = xml || @xml

      response = Net::HTTP.post_form(uri, 'xmlrequest' => xml)

      @response = Intacct::Response.new(request_xml, Nokogiri::XML(response.body))
    end

    private

      def api_xml
        @request_xml = Nokogiri::XML::Builder.new do |xml|
          xml.request {

            Builder::Control.new(xml_doc: xml).to_xml

            Builder::Operation.new(xml_doc: xml).xml_block {

              Builder::Authentication.new(xml_doc: xml).to_xml

              Builder::Content.new(xml_doc: xml).xml_block {
                yield xml
              }

            }
          }
        end
      end

      def _control_id
        "#{intacct_object_name}_#{Time.now.to_i}"
      end


  end
end
