class LinksController < ApplicationController
    #GET links
    def index
        @links = Link.all
        render json: @links
    end    
    def show
        @links = Link.find(params[:id])
        render json: @links
    end
    def new
        @links = Link.new
    end
    def create
        @link = Link.new(short_url: params[:links][:short_url],
                         original_url: params[:links][:original_url])
        @link.save
        redirect_to @link
    end
end