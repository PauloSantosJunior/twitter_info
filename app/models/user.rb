class User < ActiveRecord::Base
  validates :name,          presence: true
  validates :password,      presence: true
  validates :postal_code,   presence: true
  validates :street_name,   presence: true
  validates :city_name,     presence: true
  validates :state_name,    presence: true
  validates :country_name,  presence: true
  validates :telephone,     presence: true
  validates :email,         presence: true


  def self.find(user_informations)
    if user_informations.class == ActionController::Parameters
      return false if user_informations.empty?
      return false if (not user_informations.has_key?("inputUserName")) or (not user_informations.has_key?("inputPassword"))
    else
      return false
    end
    user = where(
        name: user_informations[:inputUserName],
        password: user_informations[:inputPassword]
      )
    if user.any?
      user
    else
      return false
    end
  end

  def self.create(user_informations)

    user = User.new do |u|
      u.name = user_informations[:inputUserName].to_s
      u.password = user_informations[:inputPassword].to_s
      u.postal_code = user_informations[:inputPostal].to_i
      u.street_name = user_informations[:inputStreet].to_s
      u.city_name = user_informations[:inputCity].to_s
      u.state_name = user_informations[:inputState].to_s
      u.country_name = user_informations[:inputCountry].to_s
      u.telephone = user_informations[:inputTel].to_i
      u.email = user_informations[:inputEmail].to_s
    end
    if user.save
      user
    else
      false
    end

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
