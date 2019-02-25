class CarsController < ApplicationController
  def index
    @cars = Cars.all
  end

  def show
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to @car
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @car.update(car_params)
      redirect_to @car
    else
      render :edit
    end
  end

  def destroy
    @car.car.destroy

    redirect_to :root
  end

  private

  def car_params
    params.require(:car).permit(:brand, :model, :model_year, :fabrication_year, :chassis, :licens_plate, :kilometers, :price, :color, :specs, :facts, :version, :photo_one, :photo_two, :photo_three, :photo_four, :video)
  end
end
