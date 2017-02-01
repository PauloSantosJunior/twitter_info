class TwitterUser < ApplicationRecord
  validates :provider,          presence: true
  validates :name,              presence: true
  def self.find_or_create_from_auth_hash(auth_hash)
    if auth_hash.class == OmniAuth::AuthHash
      # return false if auth_hash.empty?
      # return false if (not auth_hash.has_key?("provider")) or (not auth_hash.has_key?("twuid"))
    else
      return false
    end
    user = where(provider: auth_hash.provider, twuid: auth_hash.twuid).first_or_create
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

  def self.find(auth_hash)
    user = where(provider: auth_hash.provider, twuid: auth_hash.twuid).first_or_create
    if user.any?
      user.update(
        name: user_informations[:inputusername],
        password: user_informations[:inputpassword],
      )
      return user
    else
      return false
    end
  end

end
