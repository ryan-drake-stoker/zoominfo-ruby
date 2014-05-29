module ZoomInfo
  class Company < ZoomInfo::Base
    def search(query = {})
      query = prepare_request(query)
      self.class.get("/company/search", query: query).parsed_response['CompanySearchRequest']['CompanySearchResults']
    end

    def detail(query = {})
      query = prepare_request(query)
      self.class.get("/company/detail", query: query).parsed_response
    end

    def search_by_company_name(company_name)
      search('CompanyName' => company_name)
    end
  end
end
