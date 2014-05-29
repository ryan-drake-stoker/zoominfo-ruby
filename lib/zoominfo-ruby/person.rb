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
  end
end
