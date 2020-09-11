class Link < ApplicationRecord
    #uniqness
    validates :original_url, presence: true, length: {minimum: 10}
end
