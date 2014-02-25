class HomeController < ApplicationController

  def index
    @link = Link.new
    @top_links = Link.order(clicks: :desc).first(12).each_slice(4).to_a
  end

end