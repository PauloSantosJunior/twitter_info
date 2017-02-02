require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
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
      ),
      User.create!(
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
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Provider".to_s, :count => 2
    assert_select "tr>td", :text => "Profile Image".to_s, :count => 2
    assert_select "tr>td", :text => "Token".to_s, :count => 2
    assert_select "tr>td", :text => "Secret".to_s, :count => 2
    assert_select "tr>td", :text => "Twuid".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Street Name".to_s, :count => 2
    assert_select "tr>td", :text => "City Name".to_s, :count => 2
    assert_select "tr>td", :text => "State Name".to_s, :count => 2
    assert_select "tr>td", :text => "Country Name".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
