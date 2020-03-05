class FoodItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_food_item, only: [:show, :edit,:update, :destroy]
    before_action :authorize!, only: [:create, :edit, :update, :destroy]
    
    def index

        @sections = Section.all
        
        if params[:section]
            @section = Section.find_by_name params[:section]
            @food_items = FoodItem.where(section_id: @section.id.to_s)
        else
            @food_items = FoodItem.all
        end

        if params[:search]
            @food_items = @food_items.search(params[:search])
        end
      
        if params[:sort]
            if params[:dir]
              @dir = params[:dir]
            else
              @dir = 'asc'
            end
            @food_items = @food_items.order("#{params[:sort]} #{@dir}")
        end
      
    end

    # GET /food_items/1
    # GET /food_items/1.json
    def show
    end

    # GET /food_items/new
    def new
        @food_item = FoodItem.new
    end

    # GET /food_items/1/edit
    def edit
    end

    # POST /food_items
    # POST /food_items.json
    def create
        @food_item = FoodItem.new(food_item_params)
        respond_to do |format|
        if @food_item.save
            format.html { redirect_to @food_item, notice: 'food_item was successfully created.' }
            format.json { render :show, status: :created, location: @food_item }
        else
            format.html { render :new }
            format.json { render json: @food_item.errors, status: :unprocessable_entity }
        end
        end
    end

    # PATCH/PUT /food_items/1
    # PATCH/PUT /food_items/1.json
    def update
        respond_to do |format|
        if @food_item.update(food_item_params)
            format.html { redirect_to @food_item, notice: 'food_item was successfully updated.' }
            format.json { render :show, status: :ok, location: @food_item }
        else
            format.html { render :edit }
            format.json { render json: @food_item.errors, status: :unprocessable_entity }
        end
        end
    end

    # DELETE /food_items/1
    # DELETE /food_items/1.json
    def destroy
        @food_item.destroy
        flash[:notice] = 'Food Item successfully deleted.'
        redirect_to food_items_path
    end

    private

    # Only allow a list of trusted parameters through.
    def food_item_params
      params.require(:food_item).permit(:name, :description, :price, :meal_number, :image_url, :section_id, :id)
    end

    def find_food_item
        @food_item = FoodItem.find params[:id]
        if @food_item === nil
            redirect_to root_path, notice: "Food Item Does Not Exist"
        end
    end

    def authorize!
        unless can?(:crud, @food_item)
            redirect_to root_path, alert: 'Not Authorized'
        end
    end

end
