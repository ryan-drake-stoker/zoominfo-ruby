module ZoomInfo
  class Usage < ZoomInfo::Base

    def search(query = {})
      query = query.delete_if{|k,v| v.nil? || v.strip.length < 1}
      query = prepare_request(query)
      res = self.class.get("/usage/query", query: query)
      res.parsed_response
    end


    def current_usage
      query = {'queryTypeOptions' => "company_search_query,person_detail"}
      search(query)
    end


  end
end
