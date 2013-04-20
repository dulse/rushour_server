require 'bundler/setup'
require 'rubygems'
require 'active_record'

$: << File.expand_path(File.join(__FILE__, '..', 'lib'))

require 'awesome_print'
require 'grape'
require 'api'
require 'rushour'

ActiveRecord::Base.establish_connection(host:     'localhost',
                                        adapter:  'mysql2',
                                        database: 'rushour',
                                        username: 'rushour',
                                        password: 'SomeReallyTerriblePassword123')
