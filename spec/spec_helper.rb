$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'byebug'
require 'poppy/rails'
require 'active_record'

#ActiveRecord::Base::establish_connection(adapter: 'sqlite3',
#                                         database: ':memory:')
ActiveRecord::Base::establish_connection(adapter: 'postgresql',
                                         database: 'poppy-rails-test')

load File.dirname(__FILE__) + '/support/schema.rb'
