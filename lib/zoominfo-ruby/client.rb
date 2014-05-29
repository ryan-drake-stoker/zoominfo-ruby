module ZoomInfo
  class Base
    include KeyGeneration
    include HTTParty
    base_uri 'partnerapi.zoominfo.com/partnerapi/'
    format :xml
    attr_accessor :api_key

    def initialize(partner_name = nil, api_key = nil)
      @api_key = api_key
      self.class.default_params({pc: partner_name, outputType: 'xml'})
    end
  end

  class Company < ZoomInfo::Base
    def search(query = {})
      key = generate_key(query.values, @api_key)
      query.merge!(key: key)
      self.class.get("/company/search", query: query).parsed_response['CompanySearchRequest']['CompanySearchResults']
    end

    def detail(query = {})
      key = generate_key(query.values, @api_key)
      query.merge!(key: key)
      self.class.get("/company/detail", query: query).parsed_response
    end
  end
end
