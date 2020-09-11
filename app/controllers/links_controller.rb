class LinksController < ApplicationController
    #GET links
    def index
        @links = Link.all
        render json: @links
    end    
    #GET 1 links
    def show
        @links = Link.find_by(short_url: params[:short_url])
        render json: @links
    end
    #POST link
    def create
        @link = Link.new(original_url: params[:links][:original_url])

        if @link.save
            redirect_to @link
        else
            render json: '{ok: 0}'
        end
    end
    #DELETE link
    def destroy
        @link = Link.find(params[:id])
        @link.destroy
    end

    private
    def article_params
            params.require(:links).permit(:original_url)
    end
end