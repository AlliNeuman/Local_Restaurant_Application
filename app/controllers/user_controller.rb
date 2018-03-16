class UserController < ApplicationController

  get '/home' do
    if !logged_in?
      redirect to '/restaurants'
    else
      # changed the below line from creator to user to check code
      # @creator = User.find_by_id(session[:user_id])
      @user = User.find_by_id(session[:user_id])
      # erb :'users/show'
      erb :'users/home'
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
      if user_params_blank?
        flash[:message] = "Make sure to enter a username and password. They must meet the requirements shown."
        redirect to '/signup'
      else
        @creator = User.new(:username => params[:username], :password => params[:password])
        @creator.save
        session[:user_id] = @creator.id
        flash[:message] = "You have successfully created an account."
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
