class HuntsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_hunt, only: %i(show play)

  def index
    @hunts = Hunt.all
    if city = params[:hunt][:city]
      @hunts = @hunts.near(city, 200)
    end
    if category_id = params[:hunt][:category].to_i
      @hunts = @hunts.where(category_id: category_id)
    end
  end



  def show
  end

  def play
    @checkpoints = @hunt.checkpoints
    @hash = Gmaps4rails.build_markers(@checkpoints) do |checkpoint, marker|
      marker.lat checkpoint.lat
      marker.lng checkpoint.log
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
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
