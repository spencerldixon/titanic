require 'rails/generators'
module Titanic
  class InstallGenerator < Rails::Generators::Base
    def install
      # Load rake tasks into project
      content = 'spec = Gem::Specification.find_by_name "titanic-db"' + "\n" + 'load "#{spec.gem_dir}/lib/tasks/titanic.rake"'
      append_to_file 'Rakefile', content
    end
  end
end

