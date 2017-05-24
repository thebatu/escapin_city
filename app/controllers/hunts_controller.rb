class HuntsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_hunt, only: %i(show)

  def index
    @hunts = Hunt.all
    if city = params[:hunt][:city]
      @hunts = @hunts.near(city, 200)
    end
    if category_id = params[:hunt][:category].to_i
      @hunts = @hunts.where(category_id: category_id)
    end
    @hunts
  end



  def show
  end

  def play
  end

  private

  def search_params
    params.require(:hunt).permit(:city, :category)
  end

  def set_hunt
    @hunt = Hunt.find(params[:id])
  end
end
