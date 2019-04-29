namespace :sidekiq do
  desc "Start Sidekiq Monitor (standalone)"
  task :monitor => :environment do
    require 'sidekiq/web'
    app = Sidekiq::Web
    app.set :environment, Rails.env.to_sym
    app.set :bind, '0.0.0.0'
    app.set :port, 9494
    app.run!
  end

  desc "Create books via Sdekiq"
  task :create_books => :environment do
    20000.times { CreatorWorker.perform_async }
  end

  desc "Index Things into Elasticsearch"
  task :index_things => :environment do
    Book.all.pluck( Book.primary_key ).each {|id| IndexerWorker.perform_async(id) }
  end
end
