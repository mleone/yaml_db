class Railtie < Rails::Railtie
  rake_tasks do
    load File.expand_path('../../../tasks/yaml_db_tasks.rake', __FILE__)
  end
end
