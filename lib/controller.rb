class Controller
  attr_accessor :request, :response

  def render(options = {})
    out = case options
          when String, Symbol
            render_to_string(options)
          when Hash
            options[:text]
          end

    response.write out
  end

  private
  def render_to_string(template)
    path = template_path(template)
    ERB.new(File.read(path)).result(binding)
  end

  def template_path(template)
    File.expand_path("../views/#{controller_name}/#{template}.html.erb", __FILE__)
  end

  def controller_name
    self.class.name[/^(\w+)Controller$/, 1].downcase
  end
end
