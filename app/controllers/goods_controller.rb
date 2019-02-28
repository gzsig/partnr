class GoodsController < ApplicationController
  before_action :set_good, only: %i[show edit update]
  before_action :set_good_status, only: %i[show edit update]

  def index
    @fabrication_year_range = (Good.oldest_good_fabrication_year..Time.now.year + 1).to_a
    @min_price = Good.min_good_price.to_i
    @max_price = Good.max_good_price.to_i

    query = params[:query]
    # brand = params[:brand]
    fabrication_year = params[:fabrication_year]
    price = params[:price]
    # color = params[:color]
    # body_style = params[:body_style]

    @goods = Good.all
    @goods = Good.search_by_brand_and_model(query) unless query.nil?
    # @goods = @goods.where(brand: brand) unless brand.empty?
    @goods = @goods.where('fabrication_year >= ?', fabrication_year) unless fabrication_year.nil?
    @goods = @goods.where(price: price) unless price.nil?
    # @goods = @goods.where(color: color) unless color.empty?
    # @goods = @goods.where(body_style: body_style) unless body_style.empty?
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
