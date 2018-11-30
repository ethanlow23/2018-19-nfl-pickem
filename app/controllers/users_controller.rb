class UsersController < ApplicationController
    def index
        session[:user_id] = nil
    end
    def register
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            redirect_to games_path
        else
            flash[:errors] = user.errors.full_messages
            redirect_to root_path
        end
    end
    def login
        if User.find_by_username(params[:user][:username]).try(:authenticate, params[:user][:password])
            session[:user_id] = User.find_by(username: params[:user][:username]).id
            redirect_to games_path
        else
            flash[:errors] = ["Invalid Combination"]
            redirect_to root_path
        end
    end
    def result
        if no_current_user
            logout
        end
    end
    def logout
        session[:user_id] = nil
        redirect_to root_path
    end
    def profile
        @user = User.find(params[:user_id])
    end
    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :password, :password_confirmation)
    end
end

