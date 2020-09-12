class Link < ApplicationRecord
    #uniqness
    #validates :original_url, presence: true, length: {minimum: 10}
    validates_presence_of :original_url
    validates_uniqueness_of: short_url
end
