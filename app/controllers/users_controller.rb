class UsersController < ApplicationController
  def login
    @user = user(params)
    if @user
      session[:user_id] = @user.id
      puts session[:user_id]
      puts @user.id
      return redirect_to controller: :twitter_info, action: :index
    else
      flash[:error] = "Usuário não encontrado."
      return redirect_to controller: :users, action: :index
    end
  end

  def new
  end

  def index
  end

  def user(user_information)
    @user = User.find(user_information).first
  end

  def create

    @user = user(params)

    if @user
      return redirect_to controller: :user, action: :index
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      return redirect_to "/auth/twitter"
    end

  end
end
