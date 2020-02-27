class WorkoutsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_workout, only: [:show, :edit,:update, :destroy]
    #must find workout before auth because otherwise workout user will be nil
    
    def index 
        @workouts = current_user.workouts.where(user_id: current_user)
    end

    def new
        @workout=Workout.new
    end

    def create
        @workout = Workout.new workout_params
        @workout.user = current_user
        if @workout.save # perform validation and if succesful it will save in db
            flash[:notice] = 'Workout Created Successfully'
            redirect_to workout_path(@workout.id)
        else
            render :new
        end
    end

    def edit    
    end

    def update
        
        if @workout.update workout_params
            flash[:notice] = 'Updated Successfully'
            redirect_to workout_path(@workout.id)
        else
            render :edit
        end
    end


    def show
        @user_workout = UserWorkout.new
        @user_workouts = @workout.user_workouts.all
    end

    def destroy
        @workout.destroy
        flash[:notice] = 'Workout successfully deleted.'
        redirect_to workouts_path
    end

    def booked 
        @workouts = current_user.booked_workouts
    end

    private

    def find_workout
        @workout=Workout.find params[:id]
    end

    def workout_params
        params.require(:workout).permit(:start_time, :end_time, :user_workouts, :user_id)
    end

end
