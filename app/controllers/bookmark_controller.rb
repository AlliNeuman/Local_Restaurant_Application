class BookmarkController < ApplicationController

  post '/bookmarks' do
    if logged_in?
      @bookmark = current_user.bookmarks.build(visited: params[:visited], restaurant_id: params[:restaurant_id], user_id: params[:user_id])
      if @bookmark.save
        flash[:message] = "You successfully bookmarked the restaurant"
        redirect to "/home"
      else
        flash[:message] = "Something went wrong. Please try to bookmark the restaurant again."
        redirect to "/restaurants/#{@bookmark.restaurant_id}"
      end
    else
      redirect to '/login'
    end
  end
end
