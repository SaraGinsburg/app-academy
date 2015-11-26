require 'json'
require 'rack'

class Flash
  def initialize(req)
    @req = req
    flash_cookie = @req.cookies['_rla_flash']
    @flash_now = flash_cookie ? JSON.parse(flash_cookie) : {}
    @flash = {}
  end

  def [](key)
    @flash_now[key] || @flash[key]
  end

  def []=(key, val)
    @flash[key] = val
  end

  def now
    @flash_now
  end

  def store_flash(res)
    res.set_cookie('_rla_flash', { path: '/', value: @flash.to_json })
  end

end
