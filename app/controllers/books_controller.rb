class BooksController < ApplicationController
    def index
        @books = Book.all
        @book = Book.new
    end
    
    
    
    def create
        p params
        
        book = Book.new(book_params)
        book.user_id = current_user.id
        if book.save
            redirect_to book_path(book)
        else
           render "/books/index" 
        end
    end
    
    
    private
    
    def book_params
       params.require(:book).permit(:title, :body) 
    end
end
