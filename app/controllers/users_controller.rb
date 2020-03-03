class UsersController < ApplicationController

    before_action :user_params, only: [:index]

    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            render :new
        end             
    end
    def show
        @users = User.all
        @user = current_user
        @user_workouts = UserWorkout.where(user_id: @user.id)
    end
    def index
        @users = User.all
    end

    private

    def user_params
        params.require(:user).permit(
        :first_name, :last_name, :email, :password, :password_confirmation, :program, :meals, :food_account, :role
        )
    end

end
