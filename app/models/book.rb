require 'elasticsearch/model'

class Book < ApplicationRecord
  include Elasticsearch::Model
  belongs_to :user

  def as_indexed_json(options={})
    self.as_json
  end
end
