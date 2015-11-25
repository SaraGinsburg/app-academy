require 'active_support'
require 'active_support/core_ext'
require 'erb'
require 'byebug'
require 'active_support/inflector'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @params = route_params.merge(@req.params)
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response ||= false
  end

  # Set the response status code and header
  def redirect_to(url)
    ensure_new_response

    res.header["location"] = url
    res.status = 302

    @already_built_response = true
    session.store_session(@res)
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    ensure_new_response

    @res["Content-Type"] = content_type
    @res.write(content)
    @res.finish

    @already_built_response = true
    session.store_session(@res)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    ensure_new_response
    controller_name = self.class.to_s.underscore

    file_name = "views/#{controller_name}/#{template_name.to_s.underscore}.html.erb"
    f = File.read(file_name)

    content = ERB.new(f).result(binding)

    render_content(content, 'text/html')
    @already_built_response = true
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    self.send(name)
    render(name)
  end

  def ensure_new_response
    raise "attempting to render twice" if already_built_response?
  end
end
