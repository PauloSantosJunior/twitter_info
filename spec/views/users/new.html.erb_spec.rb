require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      :name => "MyString",
      :provider => "MyString",
      :profile_image => "MyString",
      :token => "MyString",
      :secret => "MyString",
      :twuid => "MyString",
      :postal_code => 1,
      :street_name => "MyString",
      :city_name => "MyString",
      :state_name => "MyString",
      :country_name => "MyString",
      :telephone => 1,
      :email => "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_provider[name=?]", "user[provider]"

      assert_select "input#user_profile_image[name=?]", "user[profile_image]"

      assert_select "input#user_token[name=?]", "user[token]"

      assert_select "input#user_secret[name=?]", "user[secret]"

      assert_select "input#user_twuid[name=?]", "user[twuid]"

      assert_select "input#user_postal_code[name=?]", "user[postal_code]"

      assert_select "input#user_street_name[name=?]", "user[street_name]"

      assert_select "input#user_city_name[name=?]", "user[city_name]"

      assert_select "input#user_state_name[name=?]", "user[state_name]"

      assert_select "input#user_country_name[name=?]", "user[country_name]"

      assert_select "input#user_telephone[name=?]", "user[telephone]"

      assert_select "input#user_email[name=?]", "user[email]"
    end
  end
end
