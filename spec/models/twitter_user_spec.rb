require 'rails_helper'

RSpec.describe TwitterUser, type: :model do
  let(:valid_user) {
    ActionController::Parameters.new(provider: "Teste" , twuid: "12345678")
  }
  let(:not_found_user) {
    ActionController::Parameters.new(provider: "Testeinválido" , twuid: "154779")
  }
  let(:invalid_params){
    ActionController::Parameters.new(inputUserName: "Testeinválido")
  }

  context "Validade de um Usuário" do
    it "Usuário válido?"do
      twitter_user          = TwitterUser.new
      twitter_user.provider = "twitter"
      twitter_user.name     = "tw_informations"
      expect(twitter_user.valid?).to be_truthy
    end

    it "Usuário inválido?"do
      twitter_user              = TwitterUser.new
      twitter_user.provider     = ""
      twitter_user.name         = ""
      expect(twitter_user.valid?).to be_falsey
    end
  end

  context "Válidade método .find_or_create_from_auth_hash" do
    # it "Usuário cadastrado."do
    #   user_test = TwitterUser.find(valid_user)
    #   expect(user_test.any?).to be_truthy
    # end
    # it "Usuário não cadastrado."do
    #   user_test = TwitterUser.find(not_found_user)
    #   expect(user_test).to be_falsey
    # end
    # it "Argumentos não válidos?"do
    #   user_test = TwitterUser.find(invalid_params)
    #   expect(user_test).to be_falsey
    # end
  end

end
