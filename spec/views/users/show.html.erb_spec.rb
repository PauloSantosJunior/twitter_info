require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :name => "Name",
      :provider => "Provider",
      :profile_image => "Profile Image",
      :token => "Token",
      :secret => "Secret",
      :twuid => "Twuid",
      :postal_code => 2,
      :street_name => "Street Name",
      :city_name => "City Name",
      :state_name => "State Name",
      :country_name => "Country Name",
      :telephone => 3,
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Provider/)
    expect(rendered).to match(/Profile Image/)
    expect(rendered).to match(/Token/)
    expect(rendered).to match(/Secret/)
    expect(rendered).to match(/Twuid/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Street Name/)
    expect(rendered).to match(/City Name/)
    expect(rendered).to match(/State Name/)
    expect(rendered).to match(/Country Name/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Email/)
  end
end
