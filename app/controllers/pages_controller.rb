class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home; end

  def partnrs
    if current_user.adm?
      @goods = Good.all
    else
      @goods = current_user.goods
    end
  end

  def confirmation
    @good = Good.find(params[:good_id])
    head :forbidden unless @good.users.include? current_user
  end


end
