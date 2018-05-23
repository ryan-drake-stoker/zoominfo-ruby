require_relative 'upper_case_camelize'
module ZoomInfo
  class Company < ZoomInfo::Base
    include UpperCaseCamelize

    def search(query = {})
      query = prepare_request(query)
      capatilizeHashKeys self.class.get("/company/search", query: query).parsed_response
    end

    def detail(query = {})
      query = prepare_request(query)
      res = self.class.get("/company/detail", query: query).parsed_response
      res['CompanyDetailRequest']
    end

    def search_by_company_name(company_name)
      search('CompanyName' => company_name)
    end

    def search_by_company_name_in_industries(company_name, industries)
      search('CompanyName' => company_name, 'IndustryClassification' => industries)
    end

    def detail_by_domain_name(domain_name)
      #sanitize url
      domain_name = domain_name.gsub(/http[s]*:\/\//, "").gsub(/\/\w*/, "")
      detail('CompanyDomain' => domain_name)
    end

    def detail_by_id(zoominfo_id)
      detail('CompanyID' => zoominfo_id)
    end

    # Runs 2 API calls, first to people search, second to company detail
    def company_by_email(email_address)
      company_id = Person.new(@partner_name, @api_key).search_by_email(email_address)['PeopleSearchRequest']['PeopleSearchResults']['CurrentEmployment']['Company']['CompanyID']
      detail('CompanyID' => company_id)
    end

  end
end
