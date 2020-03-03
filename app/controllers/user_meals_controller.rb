class UserMealsController < ApplicationController

    before_action :authenticate_user!
    before_action :find_food_item, only: [:create]

    def index
        @user = current_user
        if @user.is_admin?
            @user_meals = UserMeal.all.order(created_at: :DESC)
        else
            @user_meals = UserMeal.where(user_id:current_user.id)
        end
    end

    def show
    end

    def order_by_meal
        @user_meal = UserMeal.new
        @food_item = FoodItem.find params[:food_item_id]
        @user_meal.meal_number = @food_item.meal_number
        
        create
    end

    def order_by_price
        @user_meal = UserMeal.new
        food_item = FoodItem.find params[:food_item_id]
        @user_meal.price = food_item.price

        create
    end


    def new
        # binding.pry
        # @user_meal = UserMeal.new
        # @food_item = FoodItem.find params[:food_item_id]
         
        create
    end

    def create
        @user = current_user
        @user_meal.user = current_user
        @food_item = FoodItem.find params[:food_item_id]
        
        if @user.meals == 0 && @user_meal.meal_number != nil
            flash[:danger] = "You have no meals left. Please order by price."
            redirect_to food_items_path

        else
            @user_meal.food_item_id = @food_item.id
        
            if @user_meal.save
                # binding.pry
                if @user_meal.meal_number == nil
                    @user.food_account = @user.food_account + @user_meal.price
                    @user.save
                else
                    @user.meals = @user.meals - @user_meal.meal_number
                    @user.save
                end
                flash[:success] = "Your food is ordered"
                redirect_to food_items_path
            else
                flash[:danger] = "Something went wrong. Please try again."
                redirect_to food_items_path
            end
        end

    end

    private

    def find_user_meal
        @user_meal = UserMeal.find(params[:id])
    end

    def user_meal_params
        params.require(:user_meal).permit(:user_id, :food_item_id, :price, :meal_number, :comment, :created_at, :updated_at)
    end

    def find_food_item 
        @food_item = FoodItem.find params[:food_item_id]
    end


end
