# Abril Heartbeat

This GEM is a middleware which adds a heartbeat route to your Apps, a route which checks your external dependencies such as MySQL, Mongo, Redis and REST APIs.  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'abril_heartbeat'
```

Set the middleware on your app.

Rails Example
In the config/application.rb file add the following middleware.

```ruby
config.middleware.use "AbrilHeartbeat::Middleware"
```

Then access the `/heartbeat` in your app.

Response's example
```javascript
[{
  MONGO: {
    status: "FAIL",
    status_message: "Could not connect to any secondary or primary nodes for replica set <Moped::Cluster nodes=[<Moped::Node resolved_address="
    127.0.0.1: 27017 ">]>"
  }
}]
```

### REST Configuration

Create a heartbeat.yml to your REST APIs.

heartbeat.yml example:
```yaml
api_success:
  url: 'http://some.awesomeapi.com'
  type: 'rest'

api_not_found:
  url: 'http://another.api.com'
  type: 'rest'
```

For APIs checking, create a heartbeat.yml and pass it in the middleware initialization:
```ruby
config.middleware.use "AbrilHeartbeat::Middleware", :file_path => "#{File.dirname(__FILE__)}/heartbeat.yml"
```

Response's example
```javascript
[{
  REST: [{
    api_success: {
      url: "http://some.awesomeapi.com",
      status: 200,
      status_message: "OK"
    }
  }, {
    api_not_found: {
      url: "http://another.api.com",
      status: 404,
      status_message: "Page Not Found"
    }
  }, {
    api_wrong_url: {
      url: "I am a wrong url",
      status: null,
      status_message: "bad URI(is not URI?): http://I am a wrong url"
    }
  }]
}, {
  MONGO: {
    status: "FAIL",
    status_message: "Could not connect to any secondary or primary nodes for replica set <Moped::Cluster nodes=[<Moped::Node resolved_address="
    127.0.0.1: 27017 ">]>"
  }
}]
```

### Redis Configuration

By Default we access a REDIS client variable, which contains the redis client.

### Mongo Configuration

By default we use the Mongoid class of your app to check the connection.

### ActiveRecord Configuration

By default we use the ActiveRecord to check the connection.

## Creating your own checkers.

In the middleware initialization you can pass your own checkers:

```ruby
config.middleware.use "AbrilHeartbeat::Middleware", {custom_checkers: [YourCustomCheckerClass]}
```

You custom checker class must implement the `AbrilHeartbeat::AbstractChecker` interface.

## Future

* add new MongoDrivers to support more apps
* use the yaml file to get the Redis client instance
* basic auth? At this moment you must handle the request before our middleware
* add an initializer to config the heartbeat route


## Contributing

1. Fork it ( https://github.com/abril/abril_heartbeat/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
