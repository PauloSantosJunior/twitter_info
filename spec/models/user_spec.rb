require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_user) {
    ActionController::Parameters.new(inputUserName: "Teste" , inputPassword: "12345678")
  }
  let(:not_found_user) {
    ActionController::Parameters.new(inputUserName: "Testeinválido" , inputPassword: "154779")
  }
  let(:invalid_params){
    ActionController::Parameters.new(inputUserName: "Testeinválido")
  }

  context "Validade de um Usuário" do
    it "Usuário válido?"do
      user              = User.new
      user.name         = "Teste"
      user.email        ="teste@teste.com.br"
      user.password     = "1234578"
      user.postal_code  = 7190050
      user.street_name  = "Av. Odair Santanelli"
      user.city_name    = "Guarulhos"
      user.state_name   = "São Paulo"
      user.country_name = "Brasil"
      user.telephone    = 5511999999999
      expect(user.valid?).to be_truthy
    end

    it "Usuário inválido?"do
      user              = User.new
      user.name         = ""
      user.email        =""
      user.password     = ""
      user.postal_code  = ""
      user.street_name  = ""
      user.city_name    = ""
      user.state_name   = ""
      user.country_name = ""
      user.telephone    = ""

      expect(user.valid?).to be_falsey
    end
  end

  context "Válidade método .find" do
    it "Usuário cadastrado."do
      user_test = User.find(valid_user)
      expect(user_test.any?).to be_truthy
    end
    it "Usuário não cadastrado."do
      user_test = User.find(not_found_user)
      expect(user_test).to be_falsey
    end
    it "Argumentos não válidos?"do
      user_test = User.find(invalid_params)
      expect(user_test).to be_falsey
    end
    it "Argumentos não válidos?"do
      user_informations = "teste"
      user_test = User.find(user_informations)
      expect(user_test).to be_falsey
    end
  end
end
