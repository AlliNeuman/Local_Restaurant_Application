class RestaurantController < ApplicationController

  get '/restaurants' do
    if logged_in?
      @created_restaurants = Restaurant.all
      erb :'restaurants/index'
    else
      redirect to '/login'
    end
  end

  get '/restaurants/new' do
    if logged_in?
      erb :'restaurants/new'
    else
      redirect to '/login'
    end
  end

  get '/restaurants/:id' do
    if logged_in?
      @created_restaurant = Restaurant.find_by(id: params[:id])
      erb :'restaurants/show'
    else
      redirect to '/login'
    end
  end

  get '/restaurants/:id/edit' do
    if logged_in?
      @created_restaurant = Restaurant.find_by(id: params[:id])
      if @created_restaurant && @created_restaurant.creator == current_user
        erb :'restaurants/edit'
      else
        redirect to "/restaurants/#{@created_restaurant.id}"
      end
    else
      redirect to '/login'
    end
  end

  post '/restaurants' do
    if logged_in?
      if params[:name] == "" || params[:street_address] == "" || params[:neighborhood] == "" || params[:category] == "" || params[:tips] == ""
        flash[:message] = "Make sure to fill out all fields."
        redirect to "/restaurants/new"
      else
        @created_restaurant = current_user.created_restaurants.build(name: params[:name], neighborhood: params[:neighborhood], street_address: params[:street_address], category: params[:category], tips: params[:tips])
        if @created_restaurant.save
          Bookmark.create(user_id: @created_restaurant.user_id, restaurant_id: @created_restaurant.id)
binding.pry
          # line of code to create a bookmark automatically. Need to assign the user_id, restaurant_id and can I have a been there on the create new restaurant page?
          flash[:message] = "Your restaurant was successfully saved."
          redirect to "/restaurants/#{@created_restaurant.id}"
        else
          flash[:message] = "Make sure to save your restaurant entry."
          redirect to "/restaurants/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  patch '/restaurants/:id' do
    if logged_in?
      if params[:name] == "" || params[:street_address] == "" || params[:neighborhood] == "" || params[:category] == "" || params[:tips] == ""

        flash[:message] = "Please input information to all fields."
        redirect to "/restaurants/#{params[:id]}/edit"
      else
        @created_restaurant = Restaurant.find_by_id(params[:id])
        if @created_restaurant && @created_restaurant.creator == current_user
          if @created_restaurant.update(name: params[:name], neighborhood: params[:neighborhood], street_address: params[:street_address], category: params[:category], tips: params[:tips])
            flash[:message] = "You have successfully edited your restaurant entry."
            redirect to "/restaurants/#{@created_restaurant.id}"
          else
            flash[:message] = "Do you want to save your edits?"
            redirect to "/restaurants/#{@created_restaurant.id}/edit"
          end
        else
          flash[:message] = "Sorry, you're not authorized to edit this entry."
          redirect to '/restaurants'
        end
      end
    else
      flash[:message] = "Please login before continuing."
      redirect to '/login'
    end
  end

  delete '/restaurants/:id' do
    if logged_in?
      @created_restaurant = Restaurant.find_by_id(params[:id])
      if @created_restaurant && @created_restaurant.creator == current_user
        @created_restaurant.delete
        flash[:message] = "You have successfully deleted your restaurant entry."
        redirect to '/'
      else
        flash.now[:notice] = "Sorry, you don't have authority to delete this restaurant entry."
      end
    else
      flash.now[:notice] = "Please log in if you would like to delete your entry."
      redirect to '/login'
    end
  end
end
