require 'securerandom'
require 'jwt'

module ZoomInfo
module OAuthTokenGenerator
  def generate_token(partner_code, api_key, email = nil)
    jwt_token = generate_jwt(api_key, partner_code, email)
    retrieve_oauth_token(jwt_token, partner_code)
  end

  def retrieve_oauth_token(jwt, partner_code)
    req_body = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
        <TokenPostInput xmlns=\"http://partnerapi.zoominfo.com/partnerapistatic/xsd/V1/TokenPostInput.xsd\">
        <pc>#{partner_code}</pc>
        <ziToken>#{jwt}</ziToken>
    </TokenPostInput>"

    res = HTTParty.post("https://partnerapi.zoominfo.com/partnerapi/v2/token",
                         :body => req_body,
                         :headers => { 'Content-Type' => 'application/xml', 'Accept' => 'application/xml'})

    res['TokenResponse']['token']
  end

  def generate_jwt(api_key, partner_code, email = nil)
      self.class.default_params({pc: partner_code, outputType: 'xml'})
      ziPayload = {ziPartnerCode: partner_code}
      ziPayload[:ziPartnerContactEmail] = email if email

      issuer = 'zoominfo'
      issue_time = Time.now.to_i
      expiry_time = issue_time + 3600
      payload = {
          iss: issuer,
          iat: Time.now.to_i,
          exp: expiry_time,
          jti: SecureRandom.uuid,
          ziPayLoad: ziPayload
      }

      JWT.encode payload, api_key, algorithm='HS256'
  end

end
end