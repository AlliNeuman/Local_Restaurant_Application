class RestaurantController < ApplicationController

  get '/restaurants' do
    @restaurants = Restaurant.all
    erb :'restaurants/index'
  end

  get '/restaurants/new' do
    erb :'restaurants/new'
  end

  post '/restaurants' do
    @restaurant = Restaurant.new(name: params[:name], neighborhood: params[:neighborhood], address: params[:address], category: params[:category], tips: params[:tips])
    if @restaurant.save
      redirect to "/restaurants/#{@restaurant.id}"
    else
      redirect to "/restaurants/new"
    end
  end
end
