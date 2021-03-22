class UsersController < ApplicationController
    def index
        @users = User.all
    
        @user = current_user
        @book = Book.new
    end
    
    def show
        @user = current_user
        @book = Book.new
    end
end
