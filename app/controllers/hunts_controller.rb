class HuntsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_hunt, only: %i(show play check)

  def index
    @hunts = Hunt.all
    city = params[:hunt][:city]
    category_id = params[:hunt][:category]
    @hunts = Hunt.search(city, category_id)
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
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  def update_checkpoints(args)
  end

  def check
    checkpoint_id = params[:check][:checkpoint_id]
    @current_checkpoint = Checkpoint.find(checkpoint_id)
    if check_pos?
      @checkpoint = @current_checkpoint.lower_item
    else
      @checkpoint = @current_checkpoint
    end
    @hash = Gmaps4rails.build_markers(@checkpoint) do |check, marker|
      marker.lat check.lat
      marker.lng check.log
    end
  end

  def check_pos?
    checkpoint_id = params[:check][:checkpoint_id]
    latitude = params[:check][:latitude]
    longitude = params[:check][:longitude]
      
  end



  private

  def search_params
    params.require(:hunt).permit(:city, :category)
  end

  def set_hunt
    @hunt = Hunt.find(params[:id])
  end
end
