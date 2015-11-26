require 'rack'
require_relative '../lib/controller_base'
require_relative '../lib/router'
require_relative '../lib/flash'
require_relative '../lib/exception_middleware'
require_relative '../lib/static_assets_middleware'
require_relative 'dog'

router = Router.new

router.draw do
  get Regexp.new("^/dogs$"), DogsController, :index
  get Regexp.new("^/dogs/new$"), DogsController, :new
  get Regexp.new("^/dogs/(?<id>\\d+)$"), DogsController, :show
  post Regexp.new("^/dogs$"), DogsController, :create
end

dog_app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

app = Rack::Builder.new do
  # use ExceptionMiddleware
  use StaticAssetsMiddleware
  run dog_app
end.to_app


Rack::Server.start(
 app: app,
 Port: 3000
)
