class HuntsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_hunt, only: %i(show)

  def index
    if params[:hunt][:city] == nil || params[:hunt][:category] == nil
      @hunts = Hunt.all
    else
      params[:hunt][:category] != nil && params[:hunt][:city] != nil
      @hunts = Hunt.near(params[:hunt][:city], 20)
    end
    @hunts
    raise
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
