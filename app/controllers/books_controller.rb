class BooksController < ApplicationController
    def index
        @books = Book.page(params[:page]).reverse_order
        @book = Book.new
    end
    
    
    
    def create
        
        book = Book.new(book_params)
        book.user_id = current_user.id
        if book.save
            flash[:notice] = "You have created book successfully."
            redirect_to book_path(book)
        else
            @book = book
            @books = Book.page(params[:page]).reverse_order
           render "/books/index" 
        end
    end
    
    def show
        @book = Book.find(params[:id])    
        @new_book = Book.new
        @book_comments = BookComment.page(params[:page]).reverse_order
        @book_comment = BookComment.new
        
    end
    
    def edit
        @book = Book.find(params[:id])
        
        # ほかのユーザーによる無断編集を阻止
        if @book.user != current_user
            flash[:alert] = "You can't edit books posted by other users."
            @books = Book.page(params[:page]).reverse_order
            @book = Book.new
            redirect_to books_path
        end
    end
    
    def update
        book = Book.find(params[:id])
        if book.update(book_params)
            flash[:notice] = "You have updated book successfully."
            redirect_to book_path(book)
        else
            @book = book
            render("/books/edit.html.erb")
        end
    end
    
    def destroy
        book = Book.find(params[:id])
        if book.destroy
            flash[:notice] = "You have deleted book successfully."
            redirect_to books_path
        else
            render("/books/show/:id")
        end
            
    end
    
    
    private
    
    def book_params
       params.require(:book).permit(:title, :body) 
    end
end
