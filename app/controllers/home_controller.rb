class HomeController < ApplicationController

    def index
        @class_schedules = ClassSchedule.all.order(start_time: :ASC)
    end

    def contact_us
    end

end
