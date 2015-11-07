$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'byebug'
require 'poppy/rails'
require 'active_record'

ActiveRecord::Base::establish_connection(adapter: 'postgresql',
                                         database: 'poppy_rails_test')

load File.dirname(__FILE__) + '/support/schema.rb'
