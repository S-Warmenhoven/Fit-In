class UsersController < ApplicationController
    before_action :find_user, only: [:edit,:update, :destroy]
    before_action :authorize!, only: [:index, :create, :edit, :update, :destroy]

    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        if @user.save
            redirect_to root_path
        else
            render :new
        end             
    end

    def show
        @users = User.all
        @user = current_user
        # if user is trainer
        @trainer_workouts = Workout
        .where(user_id:@user.id)
        .order(start_time: :ASC)
        # if user is guest
        @guest_workouts = UserWorkout.where(user_id: @user.id) 
    end

    def index
        @users = User.all
    end

    def edit    
    end

    def update
        if @user.update user_params
            flash[:notice] = 'Updated Successfully'
            redirect_to users_path
        else
            render :edit
        end
    end

    def destroy
        @user.destroy
        flash[:notice] = 'User successfully deleted.'
        redirect_to users_path
    end

    private

    def user_params
        params.require(:user).permit(
        :first_name, :last_name, :email, :password, :password_confirmation, :program, :meals, :food_account, :role
        )
    end

    def find_user
        @user = User.find params[:id]
        if @user === nil
            redirect_to root_path, notice: "User Does Not Exist"
        end
    end

    def authorize!
        unless can?(:crud, @user)
            redirect_to root_path, alert: 'Not Authorized'
        end
    end

end
