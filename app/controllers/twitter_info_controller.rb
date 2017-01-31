class TwitterInfoController < ApplicationController

  require "twitter"
  require 'google_maps_service'
  require "twitter-text"


  def index
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "id9ZdHDfje9k5XyynldVTAo8j"
      config.consumer_secret     = "rcBxu93JztnplfSX7zLVTUFdzCI23YLdZtCrQ2XFfg2nk6PVgE"
      config.access_token        = "824839316362768385-bVMRrwstfWiiVl6pjgskf5jRu8kJqTY"
      config.access_token_secret = "VHkgQaLr20HWd1ducKP35NObhKZk2buLcKrnZ6Sx33WUT"
    end
    @user = User.find_by(id: session[:user_id]) if session[:user_id]
    @twitter_user = @client.user
    @client.search("to:justinbieber marry", result_type: "recent").take(10).each do |tweet|
      puts tweet.text
    end

  end

  def twitter_search

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "id9ZdHDfje9k5XyynldVTAo8j"
      config.consumer_secret     = "rcBxu93JztnplfSX7zLVTUFdzCI23YLdZtCrQ2XFfg2nk6PVgE"
      config.access_token        = "824839316362768385-bVMRrwstfWiiVl6pjgskf5jRu8kJqTY"
      config.access_token_secret = "VHkgQaLr20HWd1ducKP35NObhKZk2buLcKrnZ6Sx33WUT"
    end

    tweets = @client.search("#{params[:search_string].to_s}", {until: params[:end_date].to_s})

  #  tweets = tweets.select {|tweet| DateTime.parse(tweet.created_at.to_s).to_date >= Date.parse(params[:start_date].to_s)}

    render partial: "search_results", locals: { tweets: tweets }

  end

  def twitter_geo_location
    coordinates = params[:coordinates].split(',')

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "id9ZdHDfje9k5XyynldVTAo8j"
      config.consumer_secret     = "rcBxu93JztnplfSX7zLVTUFdzCI23YLdZtCrQ2XFfg2nk6PVgE"
      config.access_token        = "824839316362768385-bVMRrwstfWiiVl6pjgskf5jRu8kJqTY"
      config.access_token_secret = "VHkgQaLr20HWd1ducKP35NObhKZk2buLcKrnZ6Sx33WUT"
    end

    user = @client.user

    lat   = coordinates[0]
    long  = coordinates[1]

    tweets = @client.search("",geocode: "#{lat.to_s},#{long.to_s},5km",result_type: "recent")

    tweets = tweets.select {|tweet| not tweet.place.nil?}

    render json: tweets
  end

end
