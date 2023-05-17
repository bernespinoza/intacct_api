module IntacctApi
  class GetBillList < Base
    attr_reader :limit, :get_list, :filters, :sorts

    def initialize(limit: 10)
      @limit = limit.to_i
      @filters = {}
      @sorts = {}
      @get_list = IntacctApi::GetList
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
      get_list.new(intacct_object_name: 'bill'.freeze,
                    limit: limit,
                    filters: filters,
                    sorts: sorts).build_xml
    end

  end
end
