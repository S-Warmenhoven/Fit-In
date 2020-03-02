module ApplicationHelper

    def readable_time(time)
        time.strftime("%I:%M%P")
    end

    def user_friendly_range datetime
        return datetime.strftime("%B %d %Y %I:%M%P")
    end

    def use_day_only date
        return date.day
    end
    
    def author_of(record)
        user_signed_in? && current_user.id == record.user_id
    end
    
    def admin?
        user_signed_in? && current_user.is_admin?
    end

end
