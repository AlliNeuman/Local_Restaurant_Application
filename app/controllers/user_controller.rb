class UserController < ApplicationController

  get '/users' do
    erb :'/users/all'
  end

  get '/users/:slug' do
    @creator = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/restaurants'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @creator = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @creator.save
      session[:user_id] = @creator.id
      redirect to '/restaurants'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/users/:slug'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/users/:slug"
    else
      redirect to "/signup"
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
