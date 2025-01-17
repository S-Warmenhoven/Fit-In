class SessionsController < ApplicationController

    def new
        user = User.new
    end

    def create
        user = User.find_by_email params[:email]

        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_path, notice: "Signed In"
        else
            flash[:alert] = "Sorry, wrong email or password."
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Signed out!"
    end

end
