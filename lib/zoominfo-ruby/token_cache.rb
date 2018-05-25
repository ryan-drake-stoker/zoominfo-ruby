require 'singleton'


class TokenCache
  include Singleton

  def initialize
    @data = {}
  end

  def add_token(key, token)
    @data[key] = {time: Time.now, token: token}
  end

  def retrieve_token(key)
    token_pair = @data[key]
    if token_pair && token_pair[:time].to_i > (Time.now.to_i - 3000)
      token_pair[:token]
    else
      nil
    end
  end

  def version
    '0.0.1'
  end


end