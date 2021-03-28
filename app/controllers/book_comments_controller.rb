class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    book_comment = BookComment.new(book_comment_params)
    book_comment.user_id = current_user.id
    book_comment.book_id = book.id
    if book_comment.save
      flash[:notice] = "You have created comment successfully."
      redirect_to request.referer
    else
      @book = book   
      @new_book = Book.new
      @book_comments = BookComment.page(params[:page]).reverse_order
      @book_comment = book_comment
      render "books/show"
    end
  end

  def destroy
    book = Book.find(params[:book_id])
    book_comment = book.book_comments.find(params[:id])
    
    if book_comment.destroy
      flash[:notice] = "You have deleted comment successfully."
      redirect_to request.referer
    else
      flash[:alert] = "Your comment was not deleted. Please try again."
      @book = book   
      @new_book = Book.new
      @book_comments = BookComment.page(params[:page]).reverse_order
      @book_comment = book_comment
      render "books/show"
    end
    
  end
  
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
