require 'rails/generators'
module Titanic
  class InstallGenerator < Rails::Generators::Base
    def install
      # Add security certificate for Net SSH and install it
      system 'curl -O https://raw.github.com/net-ssh/net-ssh/master/gem-public_cert.pem'
      system 'gem cert --add gem-public_cert.pem'
      system 'gem install net-scp -P HighSecurity'

      # Load rake tasks into project
      content = 'spec = Gem::Specification.find_by_name "titanic"' + "\n" + 'load "#{spec.gem_dir}/lib/tasks/titanic.rake"'
      append_to_file 'Rakefile', content
    end
  end
end

