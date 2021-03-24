class UsersController < ApplicationController
    def index
        @users = User.page(params[:page]).reverse_order
        @user = current_user
        @book = Book.new
    end
    
    def show
        @user = User.find(params[:id])
        @book = Book.new
    end
    
    def edit
        @user = User.find(params[:id])
        if @user != current_user
            flash[:alert] = "You can't edit other users' infomation."
            @users = User.page(params[:page]).reverse_order
            @user = current_user
            @book = Book.new
            render("users/index")
        end
    end
    
    def update
       user = User.find(params[:id])
        if user.update(user_params)
            flash[:notice] = "You have updated user successfully."
            redirect_to user_path(user)
        else
            @user = user
            render :edit
        end
    end
    
    private
    
    def user_params
        params.require(:user).permit(:name, :profile_image, :introduction)
    end
end
