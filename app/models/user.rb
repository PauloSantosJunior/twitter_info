class User < ActiveRecord::Base

  def self.find(user_informations)
    user = where(
        name: user_informations[:inputUserName],
        password: user_informations[:inputPassword]
      )
  end

  def self.create(user_informations)

    user = User.new do |u|
      u.name = user_informations[:inputUserName].to_s
      u.password = user_informations[:inputPassword].to_s
      u.postal_code = user_informations[:inputPostal].to_s
      u.street_name = user_informations[:inputStreet].to_s
      u.city_name = user_informations[:inputCity].to_s
      u.state_name = user_informations[:inputState].to_s
      u.country_name = user_informations[:inputCountry].to_s
      u.telephone = user_informations[:inputTel].to_s
      u.email = user_informations[:inputEmail].to_s
    end
    user.save
    user

  end

  def twitter
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key
      config.consumer_secret     = Rails.application.secrets.twitter_api_secret
      config.access_token        = token
      config.access_token_secret = secret
    end
  end
end
