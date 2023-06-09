module IntacctApi
  class Vendor
    attr_accessor :vendorid, :vendorname, :vendortype, :taxid, :paymenthod,
      :billingtype, :status, :contactinfo, :contact, :achroutingnumber,
      :paymentnotify, :achenabled, :achbankroutingnumber, :achaccounttype,
      :achremittancetype

    # replicate work in bill
    def initialize(vendor_data)
      vendor_data => {
        vendor_id: vendorid,
        name: vendorname,
        vendor_type: vendortype,
        tax_id: taxid,
        pay_method: paymenthod,
        billing_type: billingtype,
        status: status,
        ach_routing_number: (0..) | String | NilClass => achroutingnumber,
        contact_info: {
          contact: {
            contact_name: contactname,
            print_as: printas,
            company_name: companyname,
            first_name: firstname,
            last_name: lastname,
            phone_1: phone1,
            cellphone: cellphone,
            email_1: email1,
            billing_address: {
              address1: billingaddress1,
              address2: billingaddress2,
              city: billingcity,
              state: billingstate,
              zip: billingzip
            }
          } => contact
        },
        payment_notify: ^achroutingnumber | String | NilClass => paymentnotify,
        ach_enabled: ^achroutingnumber |  String |NilClass => achenabled,
        ach_bank_routing_number:  ^achroutingnumber | String | NilClass => achbankroutingnumber,
        ach_account_type: ^achroutingnumber |  String | NilClass => achaccounttype,
        ach_remittance_type: ^achroutingnumber | String | NilClass => achremittancetype
      }

      local_variables.each do |local_variable|
        next if local_variable == :vendor_data
        instance_var = "@#{local_variable}".to_sym
        instance_variable_set(instance_var, instance_eval(local_variable.to_s))
      end

    end

  end
end
