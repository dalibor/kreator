class HomeController < Controller

  def index
    @users = User.all
    render 'index'
  end
end
