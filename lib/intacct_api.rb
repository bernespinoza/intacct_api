# frozen_string_literal: true

require_relative 'intacct_api/version'
require_relative 'intacct_api/base'
require_relative 'intacct_api/response'
require_relative 'intacct_api/control'
require_relative 'intacct_api/operation'
require_relative 'intacct_api/authentication'
require_relative 'intacct_api/content'
require_relative 'intacct_api/function'
require_relative 'intacct_api/expression'
require_relative 'intacct_api/logical'
require_relative 'intacct_api/filter'
require_relative 'intacct_api/get'
require_relative 'intacct_api/functions/get_list.rb'
require_relative 'intacct_api/functions/get_bill_list.rb'
require_relative 'intacct_api/functions/get_invoice_list.rb'
require_relative 'intacct_api/functions/get_customer'
require_relative 'intacct_api/functions/get_bill'
require_relative 'intacct_api/functions/get_invoice'
require_relative 'intacct_api/functions/get_vendor'
require_relative 'intacct_api/functions/create_vendor'


module IntacctApi
  extend self

  attr_accessor :xml_sender_id  , :xml_password    ,
                :app_user_id    , :app_company_id  ,
                :app_password   , :invoice_prefix  ,
                :bill_prefix    , :vendor_prefix   ,
                :customer_prefix, :system_name     ,
                :service_url    , :customer_fields ,
                :version

  def setup
    yield self
  end
end
