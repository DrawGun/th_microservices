module Auth
  AUTH_TOKEN = %r{\ABearer (?<token>.+)\z}

  def user_id
    metadata['user_id']
  end

  def matched_token
    result = auth_header&.match(AUTH_TOKEN)
    return if result.blank?

    result[:token]
  end

  alias :token :matched_token

  private

  def client
    GeocoderService::Http::Client.new
  end

  def metadata
    client.auth(matched_token)
  end

  def auth_header
    request.env['HTTP_AUTHORIZATION']
  end
end
