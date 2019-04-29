class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :article, touch: true
end
