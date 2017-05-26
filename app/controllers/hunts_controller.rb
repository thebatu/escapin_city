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

  def check_pos?loc1, loc2
    checkpoint_id = params[:check][:checkpoint_id]
    latitude = params[:check][:latitude]
    longitude = params[:check][:longitude]

    # def distance loc1, loc2

  rad_per_deg = Math::PI/180  # PI / 180
  rkm = 6371                  # Earth radius in kilometers
  rm = rkm * 1000             # Radius in meters

  # dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
  dlat_rad = (@current_checkpoint.lat - latitude) * rad_per_deg  # Delta, converted to rad

  # dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg
  dlon_rad = (@current_checkpoint.log - longitude) * rad_per_deg

  lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
  lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

  a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
  c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

  rm * c # Delta in meters

  end



  private

  def search_params
    params.require(:hunt).permit(:city, :category)
  end

  def set_hunt
    @hunt = Hunt.find(params[:id])
  end
end
