class WorkoutsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_workout, only: [:show, :edit,:update, :destroy]
    before_action :authorize!, only: [:create, :edit, :update, :destroy]
    
    def index 
        @trainers = User.all.where(role: "trainer")
        
        if params[:search]
            @trainer = User.find_by_first_name params[:search]
            @available_workouts = Workout.where(user: @trainer)
        else
            @available_workouts = Workout.all.order(start_time: :ASC)
        end

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
    end

    def destroy
        @workout.destroy
        flash[:notice] = 'Workout successfully deleted.'
        redirect_to workouts_path
    end

    private

    def find_workout
        @workout = Workout.find params[:id]
        if @workout === nil
            redirect_to root_path, notice: "Workout Does Not Exist"
        end
    end

    def workout_params
        params.require(:workout).permit(:start_time, :end_time, :user_workouts, :user_id, :id)
    end

    def authorize!
        unless can?(:crud, @workout)
            redirect_to root_path, alert: 'Not Authorized'
        end
    end

end
