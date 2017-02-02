class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def user(user_information)
    @user = User.find(user_information)
    if @user
      @user.first!
    else
      return false
    end
  end


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
  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    # @user = user(params)
    #
    # if @user
    #   flash[:error] = "Usuário já cadastrado."
    #   return redirect_to controller: :users, action: :index
    # else
    #   @user = User.create(params)
    #   if @user
    #     flash[:notice] = "Usuário cadasrado com sucesso."
    #     session[:user_id] = @user.id
    #     return redirect_to "/auth/twitter"
    #   else
    #     flash[:error] = "Tentativa de cadastro de usuário inválido."
    #     return redirect_to controller: :users, action: :new
    #   end
    # end
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    # @user = user(params)
    #
    # if @user
    #   flash[:error] = "Usuário já cadastrado."
    #   return redirect_to controller: :users, action: :index
    # else
    #   @user = User.create(params)
    #   if @user
    #     flash[:notice] = "Usuário cadasrado com sucesso."
    #     session[:user_id] = @user.id
    #     return redirect_to "/auth/twitter"
    #   else
    #     flash[:error] = "Tentativa de cadastro de usuário inválido."
    #     return redirect_to controller: :users, action: :new
    #   end
    # end
    respond_to do |format|
      if @user.update(user_params)
        format.html {redirect_to(controller: :twitter_info, action: :index , notice: 'User was successfully updated.')}
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :provider, :profile_image, :token, :secret, :twuid, :postal_code, :street_name, :city_name, :state_name, :country_name, :telephone, :email)
    end
end
