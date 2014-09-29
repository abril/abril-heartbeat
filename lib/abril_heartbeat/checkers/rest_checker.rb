require "rest_client"

module AbrilHeartbeat
  class RestChecker < AbstractChecker
    def self.is_running?
      !rest_hash.empty?
    end

    def self.run!
      messages = rest_hash.map do |key, value|
        status, message = check!{ value['url'] }
        { key => { "url" => value["url"], "status" => status, "status_message" => message }}
      end

      { module_name => messages }
    end

    def self.module_name
      "REST"
    end

    private

    def self.rest_hash
      ConfigLoader.load_by_type(:rest)
    end

    def self.check!(&block)
      url = yield
      response = RestClient.get(url)
      [response.code, "OK"]
    rescue RestClient::ResourceNotFound
      [404, "Page Not Found"]
    rescue => exception
      [nil, exception.message]
    end
  end
end
