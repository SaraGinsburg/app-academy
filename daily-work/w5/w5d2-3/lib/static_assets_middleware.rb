require 'rack'

class StaticAssetsMiddleware
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    match_data = /^\/\w+\.(?<ft>\w+)/.match(req.path)
    if match_data
      body = File.read("../public#{req.path}")
      ['200', {'Content-Type' => "#{match_data['ft']}"}, [body]]
    else
      app.call(env)
    end
  end

end
