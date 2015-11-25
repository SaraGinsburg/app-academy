require 'json'
require 'rack'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    @req = req
    rla_cookie = @req.cookies["_rails_lite_app"]
    @cookie = rla_cookie ? JSON.parse(rla_cookie) : {}
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.set_cookie('_rails_lite_app', @cookie.to_json)
  end
end
