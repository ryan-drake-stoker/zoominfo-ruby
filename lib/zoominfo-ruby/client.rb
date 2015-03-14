module ZoomInfo
  class Base
    include KeyGeneration
    include HTTParty
    base_uri 'partnerapi.zoominfo.com/partnerapi/'
    format :xml
    attr_accessor :partner_name, :api_key

    @@non_key_fields = ['SortBy', 'SortOrder', 'outputFieldOptions']

    def initialize(partner_name = nil, api_key = nil)
      @partner_name = partner_name
      @api_key = api_key
      self.class.default_params({pc: partner_name, outputType: 'xml'})
    end

    def prepare_request(query)
      key = generate_key(query.reject{|k,v| @@non_key_fields.include? k }.values, @api_key)
      query.merge!(key: key)
    end
  end

end
