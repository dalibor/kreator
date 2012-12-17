class Kreator
  def call(env)
    request = Rack::Request.new(env)
    @cookie = request.cookies["q"]
    case request.path
    when '/' then Rack::Response.new(render('index.html.erb'))
    when '/search'
      Rack::Response.new do |response|
        response.set_cookie("q", request.params["q"])
        response.redirect("/")
      end
    else Rack::Response.new("Not Found", 404)
    end
  end

  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end
end
