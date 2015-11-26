require 'erb'

class ExceptionMiddleware
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue Exception => e
      body = ERB.new(File.read('../views/error.html.erb')).result(binding)
      [500, {'Content-Type' => 'text/html'}, [body]]
    end
  end

end
