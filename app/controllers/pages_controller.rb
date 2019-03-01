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


end
