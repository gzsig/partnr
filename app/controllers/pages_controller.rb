class PagesController < ApplicationController
  def home
    redirect_to landing_path
  end

  def landing
  end
end
