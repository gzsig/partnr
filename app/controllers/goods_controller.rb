class GoodsController < ApplicationController
  before_action :set_good, only: %i[show edit update]
  before_action :set_good_status, only: %i[show edit update]

  def index
    @goods = Good.all
  end

  def show
    @users = []
    @good.partners.each do |partner|
      @users << partner.user
    end
  end

  def new
    @good = Good.new
  end

  def create
    @good = Good.new(good_params)
    if @good.save
      redirect_to @good
    else
      render :new
    end
  end

  def edit; end

  def update
    if @good.update(good_params)
      redirect_to @good
    else
      render :edit
    end
  end

  def destroy
    @good.destroy

    redirect_to :root
  end

  private

  def good_params
    params.require(:good).permit(:brand, :model, :model_year, :fabrication_year, :chassis, :licens_plate, :kilometers, :price, :color, :specs, :facts, :version, :photo_one, :photo_two, :photo_three, :photo_four, :video, :type)
  end

  def set_good
    @good = Good.find(params[:id])
  end

  def set_good_status
    set_good
    @good.set_status
  end
end
