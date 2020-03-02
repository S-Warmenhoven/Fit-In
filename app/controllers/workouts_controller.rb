class WorkoutsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_workout, only: [:show, :edit,:update, :destroy]
    #must find workout before auth because otherwise workout user will be nil
    
    def index 
        # @workouts = Workout.where(user_id: current_user)
        @workouts = Workout.all
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
        
        # @user_workout = UserWorkout.new
        # @user_workouts = @workout.user_workouts.all
        # @user_workout = @workout.find_by(user: current_user)
        # #if I'm a trainer (workout owner)
        # if @course.user == current_user 
        #     if can? :crud, @course
        #         @bookings = @course.bookings.order(created_at: :desc)
        #         @enrollments = @course.enrollments.order(created_at: :desc)
        #     else
        #         @bookings = @course.bookings.where(hidden: false).order(created_at: :desc)
        #         @enrollments = @course.enrollments.where(hidden: false).order(created_at: :desc)
        #     end
        # else #else its a student-user or room-mananger-user
        #     @bookings = @course.bookings.order(created_at: :desc)
        #     if current_user && current_user.enrollments  
        #         @enrollments = current_user.enrollments.map{
        #             |enrollment| Course.find(enrollment.course_id) 
        #         }
        #     end
        # end
    end

    def destroy
        @workout.destroy
        flash[:notice] = 'Workout successfully deleted.'
        redirect_to workouts_path
    end

    # def booked 
    #     @workouts = current_user.booked_workouts.order('user_workouts.created_at DESC')
    # end

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

end
