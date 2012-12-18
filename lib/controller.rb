class Controller
  attr_accessor :request, :response

  def render(options = {})
    out = options[:text]

    response.write out
  end
end
