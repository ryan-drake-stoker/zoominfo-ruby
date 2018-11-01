require_relative 'o_auth_token_generator'
require_relative 'token_cache'

module ZoomInfo
  class Base
    include KeyGeneration
    include HTTParty
    include OAuthTokenGenerator
    base_uri 'https://partnerapi.zoominfo.com/partnerapi/v4/'
    format :json
    attr_accessor :partner_name, :api_key

    @@non_key_fields = ['SortBy', 'SortOrder', 'outputFieldOptions', 'queryTypeOptions']

    def initialize(partner_name = nil, api_key = nil, email = nil)
      @partner_name = partner_name
      @api_key = api_key
      @email = email
      # @token ||= generate_token(@partner_name, @api_key, email)
      self.class.default_params({pc: partner_name, outputType: 'json'})
    end


    def prepare_request(query)
      query[:key] = get_token
      query[:outputType] = 'json'
      query
    end


    def get_token
      puts 'Get fancy OAuth token'
      token = TokenCache.instance.retrieve_token(@partner_name)
      if token
        return token
      else
        token  = generate_token(@partner_name, @api_key, @email)
        if token && token.strip.length > 0
          TokenCache.instance.add_token(@partner_name, token)
        end
        token
      end
    end
  end

end
