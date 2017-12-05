function rails_database_config_snippet() {
  echo "require 'yaml' ; require 'erb' ; puts YAML.load(ERB.new(File.read('config/database.yml')).result)"
}
