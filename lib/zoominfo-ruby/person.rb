module ZoomInfo
  class Person < ZoomInfo::Base
    def search(query = {})
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

    def detail_by_id(person_id)
      detail('PersonID' => person_id)
    end
  end
end
