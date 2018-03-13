class BookmarkController < ApplicationController



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
end
