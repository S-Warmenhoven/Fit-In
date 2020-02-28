class SocialEventsController < ApplicationController
  before_action :set_social_event, only: [:show, :edit, :update, :destroy]

  # GET /social_events
  # GET /social_events.json
  def index
    @social_events = SocialEvent.all
  end

  # GET /social_events/1
  # GET /social_events/1.json
  def show
  end

  # GET /social_events/new
  def new
    @social_event = SocialEvent.new
  end

  # GET /social_events/1/edit
  def edit
  end

  # POST /social_events
  # POST /social_events.json
  def create
    @social_event = SocialEvent.new(social_event_params)
    @social_event.user = current_user
    respond_to do |format|
      if @social_event.save
        format.html { redirect_to @social_event, notice: 'Social event was successfully created.' }
        format.json { render :show, status: :created, location: @social_event }
      else
        format.html { render :new }
        format.json { render json: @social_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /social_events/1
  # PATCH/PUT /social_events/1.json
  def update
    respond_to do |format|
      if @social_event.update(social_event_params)
        format.html { redirect_to @social_event, notice: 'Social event was successfully updated.' }
        format.json { render :show, status: :ok, location: @social_event }
      else
        format.html { render :edit }
        format.json { render json: @social_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /social_events/1
  # DELETE /social_events/1.json
  def destroy
    @social_event.destroy
    respond_to do |format|
      format.html { redirect_to social_events_url, notice: 'Social event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_social_event
      @social_event = SocialEvent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def social_event_params
      params.require(:social_event).permit(:title, :description, :image_url, :when, :user_id)
    end
end
