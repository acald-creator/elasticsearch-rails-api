require 'elasticsearch/model'
require 'active_record'

class Article < ApplicationRecord
  # belongs_to :users
  include Elasticsearch::Model
  include Searchable

  has_and_belongs_to_many :categories, after_add:    [ lambda { |a,c| a.__elasticsearch__.index_document } ],
    after_remove: [ lambda { |a,c| a.__elasticsearch__.index_document } ]
  has_many                :authorships
  has_many                :authors, through: :authorships
  has_many                :comments

  mapping do
    indexes :title, type: 'text' do
      indexes :suggest, type: 'completion'
    end
    indexes :url, type: 'keyword'
  end

  def as_indexed_json(options={})
    as_json.merge 'url' => "/articles/#{id}"
  end
end

# Log results
#
Article.__elasticsearch__.client = Elasticsearch::Client.new log: true

# Create index
#
Article.__elasticsearch__.create_index! force: true

# Store data
#
Article.delete_all
Article.create title: 'Ruby on Rails with Elasticsearch and Postgresql'
Article.create title: 'Ruby on Rails with Sidekiq'
Article.create title: 'Elasticsearch and its search capabilities'
Article.create title: 'Ruby on Rails and CoffeeScript'
Article.__elasticsearch__.refresh_index!


client = Elasticsearch::Client.new log:true

client.indices.delete index: 'articles' rescue nil
client.bulk index: 'articles',
  type: 'article',
  body:  Article.all.as_json.map { |a| { index: { _id: a.delete('id'), data: a } } },
  refresh: true

Article.__send__ :include, Elasticsearch::Model

response = Article.search 'Ruby';

p response.size
p response.results.size
p response.records.size
