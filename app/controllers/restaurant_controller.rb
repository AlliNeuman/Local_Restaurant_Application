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
        redirect to "/restaurants/new"
      else
        @created_restaurant = current_user.restaurants.build(name: params[:name], neighborhood: params[:neighborhood], street_address: params[:street_address], category: params[:category], tips: params[:tips])
        if @created_restaurant.save
          redirect to "/restaurants/#{@created_restaurant.id}"
        else
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
        redirect to "/restaurants/#{params[:id]}/edit"
      else
        @created_restaurant = Restaurant.find_by_id(params[:id])
        if @created_restaurant && @created_restaurant.creator == current_user
          if @created_restaurant.update(name: params[:name], neighborhood: params[:neighborhood], street_address: params[:street_address], category: params[:category], tips: params[:tips])
            redirect to "/restaurants/#{@created_restaurant.id}"
          else
            redirect to "/restaurants/#{@created_restaurant.id}/edit"
          end
        else
          redirect to '/restaurants'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/restaurants/:id' do
    if logged_in?
      @created_restaurant = Restaurant.find_by_id(params[:id])
      if @created_restaurant && @created_restaurant.creator == current_user
        @created_restaurant.delete
      end
      redirect to '/'
    else
      redirect to '/login'
    end
  end
end
