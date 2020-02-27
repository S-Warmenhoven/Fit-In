class ClassSchedulesController < ApplicationController
    before_action :authenticate_user!

    def new
        @class_schedule = ClassSchedule.new
    end

    def create
        @class_schedule = ClassSchedule.new class_schedule_params
        @class_schedule.user_id = current_user
        if @class_schedule.save
            flash[:success] = "Class schedule created!"
            redirect_to root_path
        else
            render :new
        end

    end

    def destroy
        @class_schedule = ClassSchedule.find params[:id]
        @class_schedule.destroy
        flash[:alert] = "The class schedule has been deleted."
        redirect_to root
    end

    private

    def class_schedule_params
        params.require(:class_schedule).permit(:title, :day_of_week, :start_time, :end_time)
    end
end
