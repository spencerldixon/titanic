namespace :db do
  namespace :titanic do
    desc "Pull the db from remote and replaces your local dev copy with it"
    task :sync => :environment do
      # Make a temp folder
      FileUtils.mkdir "titanic"

      # Pull db from remote to local folder
      Net::SCP.download!(
        ENV["TITANIC_SSH_HOST"],
        ENV["TITANIC_SSH_USERNAME"],
        ENV["TITANIC_SSH_FILEPATH"],
        "/titanic"
      )

      # Drop the current db
      system 'bundle exec rails db:drop RAILS_ENV=development'
      system 'bundle exec rails db:create RAILS_ENV=development'

      project_name  = Rails.application.config.session_options[:key].sub(/^_/,'').sub(/_session/,'')
      database_name = "#{project_name}_development"
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
