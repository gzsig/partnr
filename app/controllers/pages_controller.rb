class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :partnrs
  before_action :set_good, only: %i[ confirmation contract]

  def home; end

  def partnrs
    if current_user.adm?
      @goods = Good.all
    else
      @goods = current_user.goods
    end
  end

  def confirmation
    head :forbidden unless @good.users.include? current_user
    @partner = Partner.find_by(good: @good, user: current_user)
  end

  def contract
    head :forbidden unless @good.users.include? current_user
    Partner.find_by(good: @good, user: current_user).update! step: 2
  end

private

def set_good
  @good = Good.find(params[:good_id])
end

end
