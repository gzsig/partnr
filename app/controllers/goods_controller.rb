class GoodsController < ApplicationController
  before_action :set_good, only: %i[show edit update]
  before_action :set_good_status, only: %i[show edit update]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @fabrication_year_range = (Good.oldest_good_fabrication_year..Time.now.year + 1).to_a
    @good_types = Good.good_types.map(&:capitalize)
    @min_price = Good.min_good_price.to_i
    @max_price = Good.max_good_price.to_i + 100_000
    @colors = %w[Perola Branco Preto Prata Chumbo Vermelho Amarelo]
    @body_styles = %w[Hatchback Sedan SUV Conversivel Coupe]

    query = params[:query]
    good_type = params[:good_type]
    fabrication_year = params[:fabrication_year]
    price = params["/goods"][:price] unless params["/goods"].nil?
    color = params[:color]
    body_style = params[:body_style]

    @goods = Good.all
    @goods = @goods.search_by_brand_and_model(query) unless !query.present?
    @goods = @goods.where(good_type: good_type) unless !good_type.present?
    @goods = @goods.where('fabrication_year >= ?', fabrication_year) unless !fabrication_year.present?
    @goods = @goods.where('price >= ?', price) unless !price.present?
    @goods = @goods.where(color: color) unless !color.present?
    @goods = @goods.where(body_style: body_style) unless !body_style.present?
  end

  def show
    @users = []
    @good.partners.each do |partner|
      @users << partner.user
    end
  end

  private

  def good_params
    params.require(:good).permit(:brand, :model, :model_year, :fabrication_year, :serial_number, :licens_plate, :kilometers, :price, :color, :specs, :facts, :version, :photo_one, :photo_two, :photo_three, :photo_four, :video, :type)
  end

  def set_good
    @good = Good.find(params[:id])
  end

  def set_good_status
    set_good
    @good.set_status
  end
end
