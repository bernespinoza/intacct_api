# frozen_string_literal: true

require_relative 'intacct_api/version'
require_relative 'intacct_api/base'
require_relative 'intacct_api/response'

module IntacctApi
  extend self

  attr_accessor :xml_sender_id  , :xml_password    ,
                :app_user_id    , :app_company_id  ,
                :app_password   , :invoice_prefix  ,
                :bill_prefix    , :vendor_prefix   ,
                :customer_prefix, :system_name     ,
                :service_url    , :customer_fields

  def setup
    yield self
  end
end
