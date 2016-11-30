require "sinatra/base"
require "bundler/setup"

class App < Sinatra::Base
  Bundler.require(:default, settings.environment)
  require 'sinatra/json'
  DB = Sequel.connect "sqlite://db.sqlite"

  configure do
    set :views, "#{root}/app/views"
  end

  get "/" do
    page_size = params[:page_size] || 100
    @posts = Post.limit(page_size).all
    json @posts.to_json
  end

end

class Post < Sequel::Model
  plugin :json_serializer
end

