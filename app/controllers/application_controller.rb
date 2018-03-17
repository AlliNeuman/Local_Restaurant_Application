require './config/environment'
require 'sinatra/base'
require 'sinatra'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    register Sinatra::Flash
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
      params[:username] == "" || params[:password] == ""
    end

    def restaurant_params_blank?
      params[:name] == "" || params[:street_address] == "" || params[:neighborhood] == "" || params[:category] == "" || params[:tips] == ""
    end


  end
end
