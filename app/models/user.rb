class User < ActiveRecord::Base
  validates :provider,      presence: true
  validates :profile_image, presence: true
  validates :token,         presence: true
  validates :secret,        presence: true
  validates :name,          presence: true
  validates :twuid,         presence: true
  # validates :street_name,   presence: true
  # validates :city_name,     presence: true
  # validates :state_name,    presence: true
  # validates :country_name,  presence: true
  # validates :telephone,     presence: true
  # validates :email,         presence: true


  def self.find_or_create_from_auth_hash(auth_hash)
    if auth_hash.class == OmniAuth::AuthHash
      # return false if auth_hash.empty?
      # return false if (not auth_hash.has_key?("provider")) or (not auth_hash.has_key?("twuid"))
    else
      return false
    end
    user = where(provider: auth_hash.provider, twuid: auth_hash.uid).first_or_create(auth_hash)
    user.update(
      name: auth_hash.info.nickname,
      profile_image: auth_hash.info.image,
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret
    )
    user
    if user
      user
    else
      return false
    end
  end

  def self.create(auth_hash)
    user = User.new do |u|
      u.twuid         = auth_hash.uid
      u.name          = auth_hash.info.nickname
      u.profile_image = auth_hash.info.image
      u.token         = auth_hash.credentials.token
      u.secret        = auth_hash.credentials.secret
    end

    if user.save
      user
    else
      false
    end

  end
end
