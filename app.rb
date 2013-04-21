require 'bundler/setup'
require 'rubygems'
require 'active_record'
require 'uri'

$: << File.expand_path(File.join(__FILE__, '..', 'lib'))

require 'awesome_print'
require 'urbanairship'
require 'grape'
require 'api'
require 'rushour'

db = URI.parse('postgres://ec2-54-225-105-169.compute-1.amazonaws.com/dc66k8imiq7b7q')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => 'ec2-54-225-105-169.compute-1.amazonaws.com',
  :port     => '5432',
  :username => 'oiebuasqacfzhb',
  :password => 'Y2wrN2a_LBkkp6wO8u9VtVVULk',
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

Urbanairship.application_key = 'FQbCLxM5Qy-5MUQVRuciqA'
Urbanairship.application_secret = 'oyLgwEFaTSW0VPI07Tr9kw'
Urbanairship.master_secret = 'l9E6ceVyR2WhkYTtEomc4g'
Urbanairship.request_timeout = 5
