class HomeController < Controller

  def index
    render 'index'
  end

  def search
    render :search
  end
end
