class HuntsController < ApplicationController
  layout "hunts_layout", except: [:index, :show]

  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_hunt, only: %i(show play check)

  def index
    if params[:hunt]
      city = params[:hunt][:city]
      category_id = params[:hunt][:category]
      @hunts = Hunt.search(city, category_id)
    end
    #hunts = Hunt.first(8)
  end

  def show
  end

  def next_position
  end

  def prev_position
  end


  def play
    @checkpoint = @hunt.checkpoints.first
    @hash = Gmaps4rails.build_markers(@checkpoint) do |check, marker|
      marker.lat check.lat
      marker.lng check.log
      marker.title   "#checkpoint = " + @checkpoint.position.to_s
      marker.infowindow "<b>#{@checkpoint.clue}</b>"
      # marker.infowindow render_to_string(partial: "map_box", locals: { checkpoint: @checkpoint })
    end
  end

  def update_checkpoints(args)
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

    if distance < (70 + accuracy.to_f) # 70 supposed min distance to treasure
      @checkpoint = @current_checkpoint.lower_item
      @show_content = @checkpoint.content
      @checkpoint_fail = false
    else
      @checkpoint = @current_checkpoint
      @show_content = nil
      @checkpoint_fail = true
    end
    @hash = Gmaps4rails.build_markers(@checkpoint) do |check, marker|
      marker.lat check.lat
      marker.lng check.log
      marker.infowindow "<b>#{@checkpoint.clue}</b>"
    end
    @hash.push(@latitude, @longitude)
  end


  private

  def search_params
    params.require(:hunt).permit(:city, :category)
  end

  def set_hunt
    @hunt = Hunt.find(params[:id])
  end
end
