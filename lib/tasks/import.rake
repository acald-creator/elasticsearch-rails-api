namespace :import do
  desc "Import people"
  task people: :environment do
    words_path = '/usr/share/dict/words'
    fail unless File.exists?(words_path)
    two_words = []
    # iterate over file, one word per line, collect 2 words, and use for person's first and last names
    File.readlines(words_path).each do |line|
      two_words << line.strip
      if two_words.size > 1
        PersonCreatorWorker.perform_async(*two_words)
        two_words = []
      end
    end
  end
end
