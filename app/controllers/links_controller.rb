class LinksController < ApplicationController
  before_action :set_link, only: [:show]

  def show
    if params[:slug]
      @link = Link.find_by(slug: params[:slug])
      if redirect_to @link.given_url
        @link.clicks += 1
        @link.save
      end
    else
      @link = Link.find(params[:id])
    end
  end

  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to root_path, notice: 'Link was successfully created.' }
        format.js
        format.json { render action: 'show', status: :created, location: @link }
      else
        format.html { render action: 'new' }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_link
      @link = Link.find_by(slug: params[:slug])
    end

    def link_params
      params.require(:link).permit(:given_url)
    end
end
