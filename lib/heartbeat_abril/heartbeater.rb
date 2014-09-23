require "yaml"
require "rest_client"

module HeartbeatAbril
  class Heartbeater
    def initialize(file_path)
      @config = ::YAML.load_file(file_path)
    end

    def run!
      rest_run!
    end

    def rest_run!
      messages = rest.map do |key, value|
        status, message = check_rest!(value['url'])
        { key => { "url" => value['url'], "type" => value['type'], "status_code" => status, "status_message" => message }}
      end
    end

    private

    def rest
      @rest ||= @config.select{|_, value| value["type"] == "rest"}
    end

    def check_rest!(url)
      response = RestClient.get(url)
      [response.code, "OK"]
    rescue RestClient::ResourceNotFound => exception
      [404, "Page Not Found"]
    rescue => exception
      [nil, exception.message]
    end
  end
end