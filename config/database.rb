configure do
  # Log queries to STDOUT in development
 if Sinatra::Application.development?
  set :database, {
  adapter: "sqlite3",
  database: "db/db.sqlite3"
  }
else
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://umfbnhfdgmkxvt:e016833079f36ee8b28d9810c200a875c26fb8e0df7b99d5f751a7bf78509149@ec2-184-73-196-65.compute-1.amazonaws.com:5432/d4koonvq52k9m3
')
  set :database, {
  adapter: "postgresql",
  host: db.host,
  username: db.user,
  password: db.password,
  database: db.path[1..-1],
  encoding: "utf8"
  }

end

  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

end