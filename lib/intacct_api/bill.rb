module IntacctApi
  class Bill

    attr_reader :billno, :ponumber,
      :description, :externalid,
      :basecurr, :currency,
      :exchratetype, :datecreated,
      :dateposted, :datedue,
      :vendor_key, :customer_key,
      :customer, :vendor,
      :custom_fields, :bill_items,
      :line_items, :billid, :line_item

    def initialize(bill)
      bill => {
        billid: billid,
        billno: billno,
        ponumber: ponumber,
        description: description,
        externalid: externalid,
        basecurr: basecurr,
        currency: currency,
        exchratetype: exchratetype,
        datecreated: { year:_, month:_, day:_} => datecreated,
        dateposted: { year:_, month:_, day:_} =>  dateposted,
        datedue: { year:_, month:_, day:_} => datedue,
        vendor_key: vendor_key,
        customer_key: customer_key,
        customer: customer,
        vendor: vendor,
        custom_fields: custom_fields,
        bill_items: {
          base_amount_with_sales_tax:,
          mileage_amount_with_sales_tax:,
          travel_amount_with_sales_tax:,
          additional_amount_with_sales_tax:,
          standard_amount:,
          line_items: [
            {
              glaccountno:,
              amount:,
              memo:,
              locationid:,
              item1099:,
              customerid:,
              vendorid:,
              employeeid:,
              classid:
            },
          ]
        } => bill_items
      }
      @billid = billid
      @billno = billno
      @description = description
      @externalid = externalid
      @basecurr =  basecurr
      @currency = currency
      @bill_items = bill_items
      @exchratetype = exchratetype
      @datecreated = datecreated
      @dateposted = dateposted
      @datedue = datedue
      @vendor_key = vendor_key
      @customer_key = customer_key
      @customer = customer
      @vendor = vendor
      @custom_fields = custom_fields

      @line_item = build_line_item
    end

    def to_xml
      ->(xml) do
        instance_values.each_pair do |name, content|
          case content
          when Hash
            xml.send(name) do
              val_to_xml(content) do |name, value|
                if value.is_a?(Array) && value.size > 0
                  xml.send(name) do
                    xml.send(name.to_s.delete_suffix('s')) do
                      val_ary_to_xml(value) do |name, value|
                        xml.send(name, value)
                      end
                    end
                  end
                else
                  xml.send(name, value)
                end
              end
            end
          when Array
            return if content.empty?
            xml.send(name) do
              xml.send(name.to_s.delete_suffix('s')) do
                val_ary_to_xml(content) do |name, value|
                  xml.send(name, value)
                end
              end
            end
          else
            xml.send(name, content)
          end
        end
      end
    end

    def val_ary_to_xml(content, &block)
      content.each do |item|
        val_to_xml(item, &block)
      end
    end

    def val_to_xml(val, &block)
      val.each_pair do |name, value|
        block.call(name, value)
      end
    end

    def build_line_item
      OpenStruct.new(glaccount: nil,
                     amount: 0,
                     memo: nil,
                     locationid: nil,
                     'item1099' =>  nil,
                     customerid: nil,
                     vendorid: nil,
                     employeeid: nil,
                     classid: nil
                    )
    end

  end
end
