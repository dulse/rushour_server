require 'bundler/setup'
require 'rubygems'
require 'active_record'
require 'uri'

$: << File.expand_path(File.join(__FILE__, '..', 'lib'))

require 'awesome_print'
require 'grape'
require 'api'
require 'rushour'

db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :port     => db.port,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)
