class TwitterInfoController < ApplicationController

  require "twitter"
  require 'google_maps_service'
  require "twitter-text"


  def init_twitter_rest
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key
      config.consumer_secret     = Rails.application.secrets.twitter_api_secret
      config.access_token        = Rails.application.secrets.twitter_access_token
      config.access_token_secret = Rails.application.secrets.twitter_access_token_secret
    end
  end
  def index
    @client = init_twitter_rest
    @user = User.find_by(id: session[:user_id]) if session[:user_id]
    @twitter_user = @client.user
  end

  def twitter_search
    if params.empty?
      flash[:error] = "Parametros de busca inválidos"
      return redirect_to controller: :twitter_info, action: :index
    end
    if params.empty? or (not params.has_key?("search_string")) or params[:search_string].to_s.blank?
      flash[:error] = "Campos de busca não pode ser vazio."
      return redirect_to controller: :twitter_info, action: :index
    end
    @client = init_twitter_rest

    tweets = @client.search("#{params[:search_string].to_s}", { result_type: "recent", until: params[:end_date].to_s})

    tweets = tweets.select{|tweet| DateTime.parse(tweet.created_at.to_s).to_date >= Date.parse(params[:start_date].to_s)}

    render partial: "search_results", locals: { tweets: tweets }

  end

  def twitter_geo_location
    if params.empty? or (not params.has_key?("coordinates"))
      flash[:error] = "Erro na aplicação."
      return redirect_to controller: :twitter_info, action: :index
    end


    coordinates = params[:coordinates].split(',')

    @client = init_twitter_rest

    user = @client.user

    lat   = coordinates[0]
    long  = coordinates[1]

    tweets = @client.search("",geocode: "#{lat.to_s},#{long.to_s},5km",result_type: "recent")

    tweets = tweets.select{|tweet| not tweet.place.nil?}
    if tweets.empty?
      flash[:notice] = "Não existem tweets próximos de você!"
      return redirect_to controller: :twitter_info, action: :index
    end
    render json: tweets
  end

end
