class Link < ApplicationRecord
    #uniqness
    #validates :original_url, presence: true, length: {minimum: 10}
    validates_presence_of :original_url
    validates_uniqueness_of :short_url
    validate :original_url_format

    def original_url_format
        uri = URI.parse(original_url || "")
        if uri.host.nil?
            errors.add(:original_url, "invalid URL format")
        end
    end


end
