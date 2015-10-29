$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'poppy/rails'
require 'active_record'

ActiveRecord::Base::establish_connection(adapter: 'sqlite3',
                                         database: ':memory:')

load File.dirname(__FILE__) + '/support/schema.rb'
