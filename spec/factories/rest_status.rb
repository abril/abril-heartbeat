FactoryGirl.define do
  factory :api_success, class:Hash do
    initialize_with {{
      "api_success" => {
        "url" => "http://www.scudelletti.com",
        "type" => "rest",
        "status_code" => 200,
        "status_message" => "OK"
      }
    }}
  end

  factory :api_not_found, class:Hash do
    initialize_with {{
      "api_not_found" => {
        "url" => "http://www.scudelletti.com/not_found",
        "type" => "rest",
        "status_code" => 404,
        "status_message" => "Page Not Found"
      }
    }}
  end

  factory :api_wrong_url, class:Hash do
    initialize_with {{
      "api_wrong_url" => {
        "url" => "I am a wrong url",
        "type" => "rest",
        "status_code" => nil,
        "status_message" => "bad URI(is not URI?): http://I am a wrong url"
      }
    }}
  end
end
