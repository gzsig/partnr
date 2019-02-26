class PartnrsController < ApplicationController

  def index
    @partnrs = Partnr.all
  end

  def show
    @partnr = Partnr.find(params[:id])
  end

  def new
    @partnr = Partnr.new
  end

  def create
    @partnr = Partnr.new(partnr_params)
    @partnr.user = current_user
    if @partnr.save
      redirect_to @partnr
    else
      render :new
    end
  end

  def edit; end

  def update
    if @partnr.update(partnr_params)
      redirect_to @partnr
    else
      render :edit
    end
  end

  def destroy
    @partnr.destroy

    redirect_to :root
  end

private

def partnr_params
  params.require(:partnr).permit(:track_use, :other_drivers)
end

end
