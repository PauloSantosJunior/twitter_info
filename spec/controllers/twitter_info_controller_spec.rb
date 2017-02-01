require 'rails_helper'


RSpec.describe TwitterInfoController, type: :controller do

  # todos os parâmetros e valores válidos
  let(:valid_auth_api) {
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key
      config.consumer_secret     = Rails.application.secrets.twitter_api_secret
      config.access_token        = Rails.application.secrets.twitter_access_token
      config.access_token_secret = Rails.application.secrets.twitter_access_token_secret
    end
  }
  # parâmetros ausentes
  let(:invalid_auth_api){
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key
      config.consumer_secret     = Rails.application.secrets.twitter_api_secret
      config.access_token        = Rails.application.secrets.twitter_access_token
    end
  }

  let(:valid_twitter_search) {
    {
      search_string: "teste", start_date: "2017/01/29", end_date: "2017/01/30"
    }
  }

  let(:invalid_twitter_search){
    {
      search_string: "", start_date: "2017/01/29", end_date: "2017/01/30"
    }
  }
  let(:valid_twitter_geo_location) {
    {
      coordinates: "-23.451805957536905,-46.49624364235842"
    }
  }

  let(:invalid_twitter_geo_location){
    {
      coordinates: ",-46.49624364235842"
    }
  }

  describe ".init_twitter_rest" do
    context 'try to create a api' do
      it "Trying to create a valid api" do
        expect(controller.init_twitter_rest.to_json).to eq(valid_auth_api.to_json)
      end

      it "Trying to create a invalid user" do
        expect(controller.init_twitter_rest.to_json).not_to eq(invalid_auth_api.to_json)
      end
    end
  end


  describe "GET #twitter_search" do
    context 'try to make a search' do
      it "Trying to make a valid search" do
        get :twitter_search, valid_twitter_search
        expect(response).to render_template(partial: "twitter_info/search_results", locals: { tweets: [] })
      end
      it "Trying to make a invalid searchr" do
        get :twitter_search, invalid_twitter_search
        expect(response).to redirect_to controller: :twitter_info, :action => :index
      end
    end
  end

  describe "GET #twitter_geo_location" do
    context 'try to make a search and return geolocation in jason' do
      it "Trying to make a valid search" do
        get :twitter_geo_location, valid_twitter_geo_location
         expect(response.content_type).to be_eql 'application/json'
      end
      it "Trying to make a invalid searchr" do
        get :twitter_geo_location, invalid_twitter_geo_location
        expect(response).to redirect_to controller: :twitter_info, :action => :index
      end
    end
  end
end
