class LinksController < ApplicationController
    #GET links
    def index
        @links = Links.all
    end    
end