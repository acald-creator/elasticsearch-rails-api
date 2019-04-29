class IndexerWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'elasticsearch', retry: true

  Logger = Sidekiq.logger.level == Logger::DEBUG ? Sidekiq.logger : nil
  Client = Elasticsearch::Client.new host: '127.0.0.1:9200', logger: Logger

  def perform(id)
    book = Book.find(id)
    Client.index index: Book.index_name, type: Book.index_name.singularize, id: book.id, body: book.as_indexed_json
  end

end
