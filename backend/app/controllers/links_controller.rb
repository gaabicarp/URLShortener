class LinksController < ApplicationController
    #GET links
    def index
        @links = Link.all
        render json: @links
    end    
    #GET 1 links
    def show
        link = Link.find_by(short_url: params[:id])
        #binding.pry
        link.update_views_count
        redirect_to link.original_url
    end
    #POST link
    def create
        shortener = Shortener.new(link_params[:original_url])
        @link = shortener.generate_short_link
        #binding.pry
        if @link.persisted?
            render json: @link
        else
            render json: {error: 1}
        end
    end


    #DELETE link
    def destroy
        @link = Link.find(params[:id])
        @link.destroy

        @link = Link.all
        render json: @link
    end

    private
    def link_params
            params.require(:link).permit(:original_url)
    end
end