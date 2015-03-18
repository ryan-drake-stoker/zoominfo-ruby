module ZoomInfo
  class Person < ZoomInfo::Base
    def search(query = {})
      query = query.delete_if{|k,v| v.nil? || v.strip.length < 1}
      if query['SortBy'] && query['SortBy'] == "LastName"
          query['SortOrder'] = 'asc'
      end
      query = prepare_request(query)
      self.class.get("/person/search", query: query).parsed_response
    end

    def detail(query = {})
      query = prepare_request(query)
      self.class.get("/person/detail", query: query).parsed_response
    end

    def search_by_email(email_address)
      search('EmailAddress' => email_address)
    end



    def search_at_specific_company(company_id: "", firstName: nil, lastName: nil, title: nil, sortBy: nil)
      query = {'firstName' => firstName, 'lastName' => lastName, 'personTitle' => title,  'companyId' => company_id , 'companyPastOrPresent' => "1", 'SortBy' => sortBy, "outputFieldOptions" => "localAddress,companyAddress" }
      search(query)
    end

    def search_at_company_called(company_name: "", firstName: nil, lastName: nil, title: nil, sortBy: nil, industryClassification: nil)
      query = {'firstName' => firstName, 'lastName' => lastName, 'personTitle' => title,  'companyName' => company_name , 'IndustryClassification' => industryClassification, 'companyPastOrPresent' => "1", 'SortBy' => sortBy, "outputFieldOptions" => "localAddress,companyAddress"}
      search(query)
    end


    def get_first_hundred_for_company_called(company_name, industryClassification: nil)
      query = {'companyName' => company_name , 'IndustryClassification' => industryClassification,  'companyPastOrPresent' => "1", "outputFieldOptions" => "localAddress,companyAddress"}
      search(query)
    end

    def get_first_hundred_for_specific_company(zoom_company_id)
      query = {'companyId' => zoom_company_id , 'companyPastOrPresent' => "1", "outputFieldOptions" => "localAddress,companyAddress"}
      search(query)
    end

    def detail_by_id(person_id)
      detail('PersonID' => person_id)
    end
  end
end
