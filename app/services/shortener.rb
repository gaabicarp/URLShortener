class Shortener

    attr_reader :url, :link_model
    
    def initialize(url, link_model = Link)
        @url = url
        @link_model = link_model
    end

    def generate_short_link
        shrt_url = short_url_cr
        link_model.create(original_url:url, short_url: shrt_url , views_count: 0)
    end


    def short_url_cr
        loop do
            code = get_fresh_code
            break code unless link_model.exists?(short_url: code)
        end
    end

    def get_fresh_code
        SecureRandom.uuid[0..6]
    end
end