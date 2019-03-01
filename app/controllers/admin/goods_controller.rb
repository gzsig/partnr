class Admin::GoodsController < ApplicationController
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
    params.require(:good).permit(:brand, :model, :model_year, :fabrication_year, :serial_number, :licens_plate, :kilometers, :price, :color, :specs, :facts, :version, :photo_one, :photo_two, :photo_three, :photo_four, :video, :type)
  end

end
