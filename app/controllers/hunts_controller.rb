class HuntsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_hunt, only: %i(show)

  def index
    @hunts = Hunt.all
    city = params[:hunt][:city]
    category_id = params[:hunt][:category]
    @hunts = Hunt.search(city, category_id)
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
