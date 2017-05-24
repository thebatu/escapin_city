class HuntsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if search_params[:city].present?
      @hunts = Hunt.near(params[:city], 15)
    elsif search_params[:category].present?
      @hunts = Hunt(params[:category]
    else
      @hunts = Hunt.all
    end
  end

  def show
    @hunt = Hunt.find(params[:id])
  end

  # def play

  # end

  private

  def search_params
    params.require(:search).permit(:city, :category)
  end
end
