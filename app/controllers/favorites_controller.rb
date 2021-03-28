class FavoritesController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    favorite = Favorite.new(user_id: current_user.id, book_id: book.id)
    
    
    if favorite.save
      redirect_to request.referer
    else
      flash[:alert] = "Your favorite was not saved. Please try again."
      redirect_to request.referer
    end
  end



  def destroy
    book = Book.find(params[:book_id])
    favorite = book.favorites.find_by(user_id: current_user.id)
    
    if favorite.destroy
      redirect_to request.referer
    else
      flash[:alert] = "Your favorite was not deleted. Please try again."
      redirect_to request.referer
    end
  end
end
