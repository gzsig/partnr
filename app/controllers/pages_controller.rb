class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home; end

  def partnrs
    @goods = current_user.goods
  end


end
