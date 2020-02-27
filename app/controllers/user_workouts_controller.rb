class UserWorkoutsController < ApplicationController

    before_action :find_user_workout, only: [:show]

    def index
        @user_workouts = UserWorkout.all
    end

    def show
    end

    def new
        @user_workout = UserWorkout.new
    end

    private

    def find_user_workout
        @user_workout = UserWorkout.find(params[:id])
    end

    def user_workout_params
        params.require(:user_workout).permit(:user_id, :workout_id, :start_time, :end_time, :id)
    end
end
