require './config/environment'
require 'sinatra/base'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    use Rack::Flash
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def user_params_blank?
      params[:username] == "" || params[:email] == "" || params[:password] == "" || params[:username] == nil || params[:email] == nil || params[:password] == nil
    end

    def restaurant_params_blank?
      params[:name] == "" || params[:street_address] == "" || params[:neighborhood] == "" || params[:category] == "" || params[:tips] == "" || params[:name] == nil || params[:street_address] == nil || params[:neighborhood] == nil || params[:category] == nil || params[:tips] == nil
    end


  end
end
