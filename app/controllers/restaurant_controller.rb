class RestaurantController < ApplicationController

  get '/restaurants' do
    if logged_in?
      @created_restaurants = Restaurant.all
      erb :'restaurants/index'
    else
      flash[:message] = "You must be logged in to view restaurants."
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
      if restaurant_params_blank?
        binding.pry
        flash[:message] = "Make sure to fill out all fields."
        redirect to "/restaurants/new"
      else
        @created_restaurant = current_user.created_restaurants.build(name: params[:name], neighborhood: params[:neighborhood], street_address: params[:street_address], category: params[:category], tips: params[:tips])
        if @created_restaurant.save
          @created_restaurant.bookmark_saved_restaurant(params[:user_id], params[:visited])
          flash[:message] = "Your restaurant was successfully saved to the system and added to your bookmarks!"
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
      if restaurant_params_blank?
        flash[:message] = "Please input information to all fields."
        redirect to "/restaurants/#{params[:id]}/edit"
      else
        @created_restaurant = Restaurant.find_by_id(params[:id])
        if @created_restaurant && @created_restaurant.creator == current_user
          if @created_restaurant.update(name: params[:name], neighborhood: params[:neighborhood], street_address: params[:street_address], category: params[:category], tips: params[:tips])
            flash[:message] = "You have successfully edited your restaurant entry."
            redirect to "/restaurants/#{@created_restaurant.id}"
          else
            flash[:message] = "Did you want to edit your restaurant?"
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

  delete '/restaurants/:id' do  #This is not a true "delete", it removes the creator association if the creator doesn't want it anymore
    if logged_in?
      @created_restaurant = Restaurant.find_by_id(params[:id])
      if @created_restaurant && @created_restaurant.creator == current_user
        @created_restaurant.remove_creator_assocation_and_bookmark

        flash[:message] = "You have successfully removed your restaurant from your home page."
        redirect to '/home'
      else
        flash[:message] = "Sorry, you don't have authority to delete this restaurant entry."
      end
    else
      flash[:message] = "Please log in if you would like to delete your entry."
      redirect to '/login'
    end
  end
end
