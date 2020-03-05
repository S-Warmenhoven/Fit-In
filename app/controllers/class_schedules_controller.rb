class ClassSchedulesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_class_schedule, only: [:edit, :update, :destroy]
    before_action :authorize!, only: [:create, :edit, :update, :destroy]

    def new
        @class_schedule = ClassSchedule.new
    end

    def create
        if can? :crud
        @class_schedule = ClassSchedule.new class_schedule_params
        @class_schedule.user = current_user
        if @class_schedule.save
            flash[:success] = "Class schedule created!"
            redirect_to root_path
        else
            render :new
        end

    end

    def edit   
    end

    def update
        
        if @class_schedule.update class_schedule_params
            flash[:notice] = 'Updated Successfully'
            redirect_to root_path
        else
            render :edit
        end
    end

    def destroy
        @class_schedule.destroy
        flash[:alert] = "The class schedule has been deleted."
        redirect_to root_path
    end

    private

    def find_class_schedule
        @class_schedule=ClassSchedule.find params[:id]
        if @class_schedule === nil
            redirect_to root_path, notice: "Class Schedule Does Not Exist"
        end
    end

    def class_schedule_params
        params.require(:class_schedule).permit(:title, :day_of_week, :start_time, :end_time)
    end

    def authorize!
        unless can?(:crud, @class_schedule)
            redirect_to root_path, alert: 'Not Authorized'
        end
    end

end
