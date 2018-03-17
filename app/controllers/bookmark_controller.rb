class BookmarkController < ApplicationController

  # get '/bookmarks' do
  #   if logged_in?
  #     @bookmarks = Bookmark.all?
  #     erb :'users/show'
  #   else
  #     flash[:message] = "You must be logged in to view your bookmarks."
  #     redirect to "/login"
  #   end
  # end


  post '/bookmarks' do
    if logged_in?
      @bookmark = current_user.bookmarks.build(visited: params[:visited], restaurant_id: params[:restaurant_id], user_id: params[:user_id])
      if @bookmark.save
        flash[:message] = "You successfully bookmarked the restaurant."
        redirect to "/home"

      else @bookmark.errors
        flash[:message] = "You have already bookmarked the restaurant."
        redirect to "/home"

      end
    else
      redirect to '/login'
    end
  end

  patch '/bookmarks/:id' do
    if logged_in?
      @bookmark = Bookmark.find_by_id(params[:id])
      if @bookmark && @bookmark.user_id == current_user.id

        if @bookmark.update(visited: params[:visited], restaurant_id: params[:restaurant_id], user_id: params[:user_id])
          flash[:message] = "You have successfully edited your bookmark entry."
          redirect to "/home"
        else
          flash[:message] = "Did you want to edit your bookmark?"
          redirect to "/restaurants/#{@bookmark.restaurant_id}"
        end
      else
        flash[:message] = "Sorry you can only edit your own bookmarks."
        redirect to "/home"
      end
    else
      flash[:message] = "Please login before continuing."
      redirect to '/login'
    end
  end

  delete '/bookmarks/:id' do
    if logged_in?
      @bookmark = Bookmark.find_by_id(params[:id])
      if @bookmark && @bookmark.user_id == current_user.id
        @bookmark.destroy
        flash[:message] = "You have successfully deleted your bookmark."
        redirect to '/home'
      else
        flash[:message] = "Sorry, you don't have authority to delete this bookmark."
        redirect to '/home'
      end
    else
      flash[:message] = "Please log in if you would like to remove bookmark."
      redirect to '/login'
    end
  end
end
