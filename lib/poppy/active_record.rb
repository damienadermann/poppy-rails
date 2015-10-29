require 'active_record'

module Poppy
  module ActiveRecord
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def enumeration(attribute_name, **options)
        options.assert_valid_keys(:of)
        attribute attribute_name, EnumType.new(enum: options[:of])
      end
    end
  end
end
