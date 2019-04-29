require 'elasticsearch/model'

class Person < ApplicationRecord
  # include elasticsearch
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # define elasticsearch index and type for model
  index_name  'es_demo_people'
  document_type 'person'

  # custom elasticsearch mapping per autocompletion
  mapping do
    indexes :name, type: 'text'
    indexes :suggest, {
      type: 'completion',
      analyzer: 'simple',
      search_analyzer: 'simple'
    }
  end

  # simple model validation
  validates :first_name, presence: true
  validates :last_name, presence: true

  # instance method to determine how models are indexed in elasticsearch
  def as_indexed_json(_options = {})
    {
      name: "#{first_name} #{last_name}",
      suggest: {
        input: [first_name, last_name],
        output: "#{first_name} #{last_name}",
        payload: { id: id, first_name: first_name, last_name: last_name }
      }
    }
  end

  # class method to execute autocomplete search
  def self.auto_complete(q)
    return nil if q.blank?

    search_definition = {
      'name-suggest' => {
        text: q,
        completion: {
          field: 'suggest'
        }
      }
    }

    __elasticsearch__.client.perform_request('GET', "#{index_name}/_suggest", {}, search_definition).body['name-suggest'].first['options']
  end

end

__END__

Person.__elasticsearch__.create_index! force: true

GET es_demo_people/_suggest
{
  "name-suggest": {
    "text": "eric",
    "completion": {
      "field": "suggest"
    }
  }
}

GET http://localhost:9200/es_demo_people/_mapping
