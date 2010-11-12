# Capistrano task for Yaml_Db.
#
# Just add "require 'yaml_db/capistrano'" in your Capistrano deploy.rb
require 'yaml_db/deployment'

Capistrano::Configuration.instance(:must_exist).load do
  YamlDb::Deployment.define_task(self, :task, :except => { :no_release => true })
end
