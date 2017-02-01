class UsersController < ApplicationController
  def login
    @user = user(params)
    if @user
      session[:user_id] = @user.id
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
    @user = User.find(user_information)
    if @user
      @user.first!
    else
      return false
    end
  end

  def create

    @user = user(params)

    if @user
      flash[:error] = "Usuário já cadastrado."
      return redirect_to controller: :users, action: :index
    else
      @user = User.create(params)
      if @user
        flash[:notice] = "Usuário cadasrado com sucesso."
        session[:user_id] = @user.id
        return redirect_to "/auth/twitter"
      else
        flash[:error] = "Tentativa de cadastro de usuário inválido."
        return redirect_to controller: :users, action: :new
      end
    end

  end
end
