class Kreator
  def call(env)
    [ 200, { "Content-Type" => "text/plain" }, [ "Hello world!" ] ]
  end
end

run Kreator.new
