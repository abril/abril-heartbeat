require "rest_client"

module HeartbeatAbril
  class RestChecker
    def self.run!(rest_hash)
      messages = rest_hash.map do |key, value|
        status, message = check_rest!(value['url'])
        { key => { "url" => value["url"], "status" => status, "status_message" => message }}
      end

      { "REST" => messages}
    end

    def self.app_has_rest_calls?(rest_hash)
      !rest_hash.empty?
    end

    private

    def self.check_rest!(url)
      response = RestClient.get(url)
      [response.code, "OK"]
    rescue RestClient::ResourceNotFound => exception
      [404, "Page Not Found"]
    rescue => exception
      [nil, exception.message]
    end
  end
end
