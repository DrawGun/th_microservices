Application.configure do |app|
  logdev = app.production? ? STDOUT : app.root.concat('/', Settings.logger.path)

  logger = Ougai::Logger.new(
    logdev,
    level: Settings.logger.level
  )

  logger.formatter = Ougai::Formatters::Readable.new if ENV['READABLE_LOGS']

  logger.before_log = lambda do |data|
    data[:service] = { name: Settings.app.name }
    data[:request_id] = Thread.current[:request_id]
  end

  app.set :logger, logger
end

Sequel::Model.db.loggers.push(Application.logger)
