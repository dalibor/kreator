class HomeController < Controller

  def index
    render :text => 'Hello World!'
  end

  def search
    render :text => 'search'
  end
end
