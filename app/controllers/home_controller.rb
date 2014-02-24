class HomeController < ApplicationController

  def index
    @link = Link.new
    @links = Link.order(clicks: :desc)
    @top_links = Link.order(clicks: :desc).first(12).each_slice(4).to_a
  end

end