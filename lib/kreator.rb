require 'kreator/controller'
require 'kreator/model'

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
    setup_controller_class(controller_name, action_name)

    @response
  end

  private
  def route(url)
    _trash, controller_name, action_name = url.split("/")
    [controller_name || "home", action_name || "index"] # defaults to home/index
  end

  def setup_controller_class(controller_name, action_name)
    file = controller_path(controller_name)                 # home_controller
    if File.exists?("#{file}.rb")
      require file
      class_name = controller_name.capitalize + "Controller" # HomeController
      controller_class = Object.const_get(class_name)

      # register request and response object to controller
      controller = controller_class.new
      controller.request = @request
      controller.response = @response

      controller.send(action_name)
    else
      @response.status = 404
    end
  end

  def controller_path(name)
    File.expand_path("app/controllers/#{name}_controller", KREATOR_ROOT)
  end
end
