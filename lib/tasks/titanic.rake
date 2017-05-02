namespace :db do
  namespace :titanic do
    desc "Pull the db from remote and replaces your local dev copy with it"
    task :sync => :environment do
      # Make a temp folder
      FileUtils.mkdir "titanic"

      # Pull db from remote to local folder
      system "scp #{ENV["TITANIC_SSH_USERNAME"]}@#{ENV["TITANIC_SSH_HOST"]}:#{ENV["TITANIC_SSH_FILEPATH"]} /titanic"

      # Drop the current db
      system 'bundle exec rails db:drop RAILS_ENV=development'
      system 'bundle exec rails db:create RAILS_ENV=development'

      project_name  = Rails.application.config.session_options[:key].sub(/^_/,'').sub(/_session/,'')
      config        = Rails.configuration.database_configuration
      database_name = config["development"]["database"]

      bz2_files     = Dir["/titanic/*.sql.bz2"].each {|file| system "bzip2 -d #{file}" } # Extract any bz2 files
      file          = Dir["/titanic/*"].first

      # Import the db
      system "psql #{database_name} < #{file}"

      # Finish and cleanup
      # - delete temp folder and db copy
      FileUtils.remove_dir "titanic"

      puts "Done! 🛳 "
    end
  end
end
