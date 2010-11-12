module YamlDb
  class Deployment
    def self.define_task(context, task_method = :task, opts = {})
      context.send :namespace, :yaml_db do
        send :desc, <<-DESC
          Execute db:data:dump on the remote host
        DESC
        send task_method, :db_data_dump, opts do
          args = []
          rails_env = fetch(:rails_env, "no_environment_specified")
          run "cd #{context.fetch(:current_release)}; #{rake} db:data:dump #{args.join(' ')} RAILS_ENV=#{rails_env}"
        end

        send :desc, <<-DESC
          Copy db/data.yml from the remote host to local db/data.yml
        DESC
        send task_method, :db_data_copy, opts do
          args = []
          download("#{context.fetch(:current_release)}/db/data.yml", "db/data.yml", :via=> :scp)
        end

        send :desc, <<-DESC
          Execute db:data:load on the remote host
        DESC
        send task_method, :db_data_load, opts do
          args = []
          rails_env = fetch(:rails_env, "no_environment_specified")
          run "cd #{context.fetch(:current_release)}; #{rake} db:data:load #{args.join(' ')} RAILS_ENV=#{rails_env}"
        end

        send :desc, <<-DESC
          Execute db:data:dump_dir on the remote host
        DESC
        send task_method, :db_data_dump_dir, opts do
          args = []
          rails_env = fetch(:rails_env, "no_environment_specified")
          run "cd #{context.fetch(:current_release)}; #{rake} db:data:dump_dir #{args.join(' ')} RAILS_ENV=#{rails_env}"
        end

        send :desc, <<-DESC
          Execute db:data:load_dir on the remote host
        DESC
        send task_method, :db_data_load_dir, opts do
          args = []
          rails_env = fetch(:rails_env, "no_environment_specified")
          run "cd #{context.fetch(:current_release)}; #{rake} db:data:load_dir #{args.join(' ')} RAILS_ENV=#{rails_env}"
        end
      end
    end
  end
end
