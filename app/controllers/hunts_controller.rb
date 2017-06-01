class HuntsController < ApplicationController
  layout "hunts_layout", except: [:index, :show]

  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_hunt, only: %i(show play check)

  def index
    if params[:hunt]
      city = params[:hunt][:city]
      category_id = params[:hunt][:category]
      @hunts = Hunt.order(created_at: :desc).search(city, category_id)
    else
      @hunts = Hunt.order(created_at: :desc)
    end
  end

  def show
    @waypoints = @hunt.checkpoints
    # .map do |cp|
    #   {location: [cp.lat, cp.log], stopover: true}
    # end

    # @waypoints = Gmaps4rails.build_markers(@waypoints) do |check, marker|
    #   marker.lat check.lat
    #   marker.lng check.log
    # end

  end

  def play
    @checkpoint = @hunt.checkpoints.first

    @hash = Gmaps4rails.build_markers(@checkpoint) do |check, marker|
      marker.lat check.lat
      marker.lng check.log
      marker.title   "#checkpoint = " + @checkpoint.position.to_s
      # marker.infowindow "<img src = #{view_context.image_path check.photo} class = 'info_window'> <p class = 'info_window'>#{@checkpoint.clue}</p>"
    end
  end

  def check

    checkpoint_id = params[:check][:checkpoint_id]
    @current_checkpoint = Checkpoint.find(checkpoint_id)

    @latitude = params[:check][:latitude]
    @longitude = params[:check][:longitude]
    accuracy = params[:check][:accuracy]

    loc_nav = [@latitude, @longitude]
    loc_checkpoint = [@current_checkpoint.lat , @current_checkpoint.log ]

    distance = Geocoder::Calculations.distance_between(loc_nav,loc_checkpoint)
    byebug
     if @current_checkpoint.id == @hunt.checkpoints.last.id
       @end_of_game = true
     else
      if distance > (1 + accuracy.to_f) # 70 supposed min distance to treasure
        if @current_checkpoint.last?
          @checkpoint_fail = true
        else
          @checkpoint = @current_checkpoint.lower_item
          @checkpoint.content
        end
      else
        @checkpoint = @current_checkpoint
        @show_content = nil
        @checkpoint_fail = true
      end
      @hash = Gmaps4rails.build_markers(@checkpoint) do |check, marker|
        marker.lat check.lat
        marker.lng check.log
        marker.infowindow "<b>#{@checkpoint.clue}</b>"
        # marker.infowindow "<img src = #{view_context.image_path check.photo} class = 'info_window'> <b>#{@checkpoint.clue}</b>"
      end
    end
  end

  private

  def search_params
    params.require(:hunt).permit(:city, :category)
  end

  def set_hunt
    @hunt = Hunt.find(params[:id])
  end
end
