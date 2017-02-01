require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:valid_attributes) {
    ActionController::Parameters.new(inputUserName: "Teste" , inputPassword: "12345678")
  }
  let(:valid_new_user){
    {
      inputUserName: "Teste",
      inputPassword: "123456789",
      inputPostal: 7190050,
      inputStreet: "Av. Odair Santanelli",
      inputCity: "Guarulhos",
      inputState: "São Paulo",
      inputCountry: "Brasil",
      inputTel: 5511999999999,
      inputEmail: "teste@teste.com.br"
    }
  }

  let(:valid_exiting_user) {
    {
      inputUserName: "Teste",
      inputPassword: "12345678",
      inputPostal: 7190050,
      inputStreet: "Av. Odair Santanelli",
      inputCity: "Guarulhos",
      inputState: "São Paulo",
      inputCountry: "Brasil",
      inputTel: 5511999999999,
      inputEmail: "teste@teste.com.br"
    }
  }

  let(:invalid_new_user){
    {
      inputUserName: "Teste",
      inputPassword: "123456789",
      inputPostal: 7190050,
      inputStreet: "Av. Odair Santanelli",
      inputCountry: "Brasil",
      inputTel: 5511999999999,
      inputEmail: "teste@teste.com.br"
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.

  describe "GET #login" do
    context 'try to connect a user' do
      it "Trying to connect a valid user" do
        get :login, { inputUserName: "Teste" , inputPassword: "12345678"}
        expect(response).to redirect_to controller: :twitter_info, :action => :index
      end
    end
    context 'try to connect a user' do
      it "Trying to connect a invalid user" do
        get :login, { inputUserName: "Teste" , inputPassword: "senhainvaldia"}
        expect(response).to redirect_to controller: :users, :action => :index
      end
    end
  end


  describe "GET #create" do
    context 'try to create a user' do
      it "Trying to create a valid user" do
        get :create, valid_new_user
        expect(response).to redirect_to "/auth/twitter"
      end
      it "Trying to create a existing user" do
        get :create, valid_exiting_user
        expect(response).to redirect_to controller: :users, :action => :index
      end
    end
    context 'try to create a user' do
      it "Trying to create a invalid user" do
        get :create, invalid_new_user
        expect(response).to redirect_to controller: :users, :action => :new
      end
    end
  end
end
