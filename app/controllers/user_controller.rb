class UserController < ApplicationController

  get '/home' do
    if !logged_in?
      redirect to '/restaurants'
    else
      @creator = User.find_by_id(session[:user_id])
      erb :'users/show'
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      @user = current_user
      redirect to '/home'
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


    get '/login' do
      if !logged_in?
        erb :'users/login'
      else
        erb :'users/show'
      end
    end

    post '/login' do
      @creator = User.find_by(:username => params[:username])
      if @creator && @creator.authenticate(params[:password])
        session[:user_id] = @creator.id
        redirect to "/home"
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
