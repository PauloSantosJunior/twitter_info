json.extract! user, :id, :name, :provider, :profile_image, :token, :secret, :twuid, :postal_code, :street_name, :city_name, :state_name, :country_name, :telephone, :email, :created_at, :updated_at
json.url user_url(user, format: :json)