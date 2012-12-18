require 'erb'

class Kreator

  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def response
    @response = Rack::Response.new
    controller_name, action_name = route(@request.path_info)
    controller_class = load_controller_class(controller_name)

    # register request and response object to controller
    controller = controller_class.new
    controller.request = @request
    controller.response = @response

    controller.send(action_name)

    @response
  end

  private
  def route(url)
    _trash, controller_name, action_name = url.split("/")
    [controller_name || "home", action_name || "index"] # defaults to home/index
  end

  def load_controller_class(name)
    require "controllers/#{name}_controller"    # home_controller
    class_name = name.capitalize + "Controller" # HomeController
    Object.const_get(class_name)
  end
end
