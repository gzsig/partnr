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
    @partner.destroy

    redirect_to :root
  end

private

def partner_params
  params.require(:partner).permit(:track_use, :other_drivers)
end

end
