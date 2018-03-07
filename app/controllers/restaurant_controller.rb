class RestaurantController < ApplicationController

  get '/restaurants' do
    @restaurants = Restaurant.all
    erb :'restaurants/index'
  end

  get '/restaurants/new' do
    erb :'restaurants/new'
  end

  post '/restaurants' do
    if logged_in?
      if params[:name] == "" || params[:street_address] == "" || params[:neighborhood] == "" || params[:category] == "" || params[:tips] == ""
        redirect to "/restaurants/new"
      else
        @restaurant = current_user.restaurants.build(name: params[:name], neighborhood: params[:neighborhood], street_address: params[:street_address], category: params[:category], tips: params[:tips])
        if @restaurant.save
          redirect to "/restaurants/#{@restaurant.id}"
        else
          redirect to "/restaurants/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/restaurants/:id' do
    if logged_in?
      @restaurant = Restaurant.find_by(params[:id])
      erb :'restaurants/show'
    else
      redirect to '/login'
    end
  end

  get '/restaurants/:id/edit' do
    if logged_in?
      @restaurant = Restaurant.find_by(params[:id])
      if @restaurant && @restaurant.user == current_user
        erb :'restaurants/edit'
      else
        redirect to '/restaurants/#{@restaurant.id}'
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
        @restaurant = Restaurant.find_by_id(params[:id])
        if @restaurant && @restaurant.user == current_user
          if @restaurant.update(name: params[:name], neighborhood: params[:neighborhood], street_address: params[:street_address], category: params[:category], tips: params[:tips])
            redirect to "/restaurants/#{@restaurant.id}"
          else
            redirect to "/restaurants/#{@restaurant.id}/edit"
          end
        else
          redirect to '/restaurants'
        end
      end
    else
      redirect to '/login'
    end
  end



end
