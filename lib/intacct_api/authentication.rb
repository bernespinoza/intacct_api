module IntacctApi
  class Authentication
    attr_reader :xml_doc

    def initialize(xml_doc:)
      @xml_doc = xml_doc
    end

    def to_xml
      xml_doc.authentication {
        xml_doc.login {
          xml_doc.userid IntacctApi.app_user_id
          xml_doc.companyid IntacctApi.app_company_id
          xml_doc.password IntacctApi.app_password
        }
      }
    end
  end
end
