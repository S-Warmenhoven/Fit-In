class HomeController < ApplicationController

    def index
        @class_schedules = ClassSchedule.all
    end

    def contact_us
    end

end
