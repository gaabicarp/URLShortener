require 'digest/sha2'

class Shortener
    attr_reader :url, :link_model
    
    def initialize(url, link_model = Link)
        @url = url
        @link_model = link_model
    end

    def generate_short_link
        link_model.create(original_url:url, short_url: short_url)
    end


    def short_url
        i = 0
        loop do
            code = get_fresh_code(i)
            break code unless link_model.exists?(short_url: code)
            i = i + 1 
        end
    end

    def get_fresh_code(i)
        Digest::SHA256.hexdigest(url)[i..(i+6)]
    end
end