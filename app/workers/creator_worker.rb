require 'securerandom'

class CreatorWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'elasticsearch', retry: true

  Logger = Sidekiq.logger.level == Logger::DEBUG ? Sidekiq.logger : nil
  Client = Elasticsearch::Client.new host: '127.0.0.1:9200', logger: Logger


  def perform(*args)
    Book.create!({title: SecureRandom.hex})
  end
end
