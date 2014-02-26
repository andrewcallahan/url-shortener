class HomeController < ApplicationController

  def index
    @link = Link.new
    @top_links = Link.order(clicks: :desc).first(12)
  end

  def all
    @link = Link.new
    @links = Link.paginate(:page => params[:page], :per_page => 4)
  end

end