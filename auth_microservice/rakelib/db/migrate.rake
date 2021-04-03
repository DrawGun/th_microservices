namespace :db do
  desc 'Run database migrations'
  task :migrate, %i[version] => :settings do |t, args|
    require 'sequel'
    require 'pry'

    Sequel.extension :migration
    Sequel.extension :schema_dumper

    Sequel.connect(Settings.db.to_hash) do |db|
      migrations = File.expand_path('../../db/migrations', __dir__)
      version = args.version.to_i if args.version

      Sequel::Migrator.run(db, migrations, target: version)

      include Sequel::SchemaDumper

      dump = db.dump_schema_migration(indexes: true, foreign_keys: true, same_db: true)
      dump_path = File.expand_path('../../db', __dir__)
      File.write("#{dump_path}/schema.rb", dump)
    end
  end
end
