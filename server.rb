require 'sinatra'
require 'sinatra/reloader'
require_relative './app'

def development?
  ENV["ENVIRONMENT"] == 'development'
end

configure do
  set :server, :puma
  enable :reloader if development?
  also_reload '*.rb'
end

if !development?
  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    username == ENV["HTTP_USER"] and password == ENV["HTTP_PASS"]
  end
end

get '/tweets/new/?' do
  erb :new_tweets, layout: :main
end

get '/tweets/?' do
  @tweets = Tweet.all
  erb :tweets, layout: :main
end

post '/tweets/?' do
  Tweet.batch_create(params["tweets"])
  redirect "/tweets/"
end
