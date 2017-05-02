# Titanic 🛳
### Your database is syncing

Easily sync postgres databases from a remote into your local Rails application via SCP

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'titanic-db'
```

And then execute:

```ruby
bundle
```

Then run the installer...

```ruby
rails g titanic:install
```

Set up the following environment vars

```
TITANIC_SSH_HOST=staging.example.com
TITANIC_SSH_USERNAME=admin
TITANIC_SSH_FILEPATH=~/backups/database.psql
```

## Usage

`rails db:titanic:sync` - Pulls the db from the server and replaces your local development db with it

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/spencerldixon/titanic.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

