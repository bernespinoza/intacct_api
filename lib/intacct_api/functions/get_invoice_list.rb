module IntacctApi
  class GetInvoiceList < Base
    attr_reader :limit, :get_list, :filters, :sorts, :intacct_object_name

    def initialize(limit: 10)
      @limit = limit.to_i
      @filters = {}
      @sorts = {}
      @get_list = IntacctApi::GetList
      @intacct_object_name = 'invoice'.freeze
    end

    def add_filter(field:, operator:, value:, group: nil)
      filter = {field: field, operator: operator, value: value}
      if group
        group_filters =  @filters.fetch(group.to_sym, [])
        group_filters << filter
        @filters[group.to_sym] = group_filters
      else
        group_filters = @filters.fetch(:and, [])
        group_filters << filter
        @filters[:'and'] = group_filter
      end
    end

    def add_sort
    end


    def build_xml
      get_list.new(intacct_object_name: intacct_object_name,
                    limit: limit,
                    filters: filters,
                    sorts: sorts).build_xml
    end

  end
end
