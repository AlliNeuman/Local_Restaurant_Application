class UserController < ApplicationController

  # get '/users' do
  #   if logged_in?
  #     @creators = User.all
  #     erb :'users/index'
  #   else
  #     flash[:message] = "Please log in to view users."
  #     redirect to '/login'
  #   end
  # end


  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      erb :'users/show'
    end
  end

    post '/signup' do
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
        flash[:message] = "Please fill out all fields."
        redirect to '/signup'
      else
        @creator = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        @creator.save
        session[:user_id] = @creator.id
        flash[:message] = "You have successfully created an account!"
        redirect to '/restaurants'
      end
    end

    get '/users/:slug' do
      if logged_in?
        @creator = User.find_by_slug(params[:slug])
        erb :'users/show'
      else
        flash[:message] = "Please log in to view the user."
        redirect to '/login'
      end
    end

    get '/login' do
      if !logged_in?
        erb :'users/login'
      else
        erb :'users/show'
      end
    end

    post '/login' do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        erb :'users/show'
      else
        flash[:message] = "We couldn't find you. Click to sign up or check your username and password again."
        redirect to "/signup"
      end
    end

    get '/logout' do
      if logged_in?
        session.destroy
        flash[:message] = "You have successfully logged out"
        redirect to '/login'
      else
        redirect to '/'
      end
    end

  end
