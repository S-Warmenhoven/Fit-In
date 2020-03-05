class UserWorkoutsController < ApplicationController
    
    before_action :authenticate_user!
    before_action :find_workout, only: [:create]
    

    def index
        @user_workouts = current_user.user_workouts
    end

    def show
    end

    def new
        @user_workout = UserWorkout.new
        @workout = Workout.find params[:workout_id]
        
        create
    end

    def create
        @user = current_user
        @user_workouts = current_user.user_workouts
        booked_workout = UserWorkout.where(workout_id: @workout)
        if booked_workout.exists?
            flash[:danger] = "Workout session has already been booked"
            render :index
        else
            @user_workout = @user.workouts << @workout
            flash[:success] = "Your workout session is booked"
            redirect_to @workout
        end

    end

    def destroy
        @user_workout.destroy
        flash[:notice] = 'The booking has been deleted.'
        redirect_to workout_path(@user_workout.workout)
    end

    def approving
        @user_workout = UserWorkout.find(params[:user_workout_id])
        @user_workout.approving!
        redirect_to workout_path(@user_workout.workout)
    end

    def rejecting
        @user_workout = UserWorkout.find(params[:user_workout_id])
        @user_workout.rejecting!
        redirect_to workout_path(@user_workout.workout)
    end

    private

    def find_user_workout
        @user_workout = UserWorkout.find(params[:id])
    end

    def user_workout_params
        params.require(:user_workout).permit(:user_id, :workout_id, :start_time, :end_time, :id)
    end

    def find_workout 
        @workout = Workout.find params[:workout_id]
    end

end
