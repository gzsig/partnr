# allows http requests
require 'httparty'
require 'json'

class PartnersController < ApplicationController

  def index
    @partners = Partner.all
  end

  def show
    @partner = Partner.find(params[:id])
  end
  
  def new
    @good = Good.find(params[:good_id])
    @partner = Partner.new
  end

  def create
    @good = Good.find(params[:good_id])
    @partner = Partner.new(partner_params)
    @partner.good = @good
    @partner.user = current_user
    if @partner.save
      # set good status
      @good.set_status
      @good.save

      # send e-mail confirmation if all partners have liked the good
      if @good.status
        confirmation_email(@good)
      end
      redirect_to good_path(@good)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @partner.update(partner_params)
      redirect_to @partner
    else
      render :edit
    end
  end

  def destroy
    @partner = Partner.find(params[:id])
    @partner.destroy
    redirect_to :root
  end

  private

  def partner_params
    params.require(:partner).permit(:track_use, :other_drivers, :numberber_of_passengers, :km_month, :frenquency_month, :for_work)
  end

  def confirmation_email(good)
    @good = good
    Partner.where(good: good).each do |p|
      p.update! step: 1
      @user = User.where(id: p.user_id).first
      UserMailer.new_partnrs(@user, @good).deliver_now
    end
  end
end
