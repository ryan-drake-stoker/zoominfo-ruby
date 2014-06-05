module ZoomInfo
  class Company < ZoomInfo::Base
    def search(query = {})
      query = prepare_request(query)
      self.class.get("/company/search", query: query).parsed_response
    end

    def detail(query = {})
      query = prepare_request(query)
      self.class.get("/company/detail", query: query).parsed_response
    end

    def search_by_company_name(company_name)
      search('CompanyName' => company_name)['CompanySearchRequest']['CompanySearchResults']
    end

    def detail_by_domain_name(domain_name)
      detail('CompanyDomain' => domain_name)
    end

  end
end
