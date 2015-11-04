require 'active_record'
require 'active_record/connection_adapters/postgresql/oid/array'
require 'active_record/connection_adapters/postgresql_adapter'

module Poppy
  module ActiveRecord
    PostgreSQLAdapter = ::ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
    PostgreSQLArrayType = ::ActiveRecord::ConnectionAdapters::PostgreSQL::OID::Array

    DEFAULT_COLUMN_TYPE = :value

    class InvalidColumnTypeForAdapterTypeError < StandardError; end

    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def enumeration(attribute_name, **options)
        options.assert_valid_keys(:as, :of)
        column_type = options.fetch(:as, DEFAULT_COLUMN_TYPE)
        enumeration = options[:of]
        define_type(attribute_name: attribute_name, column_type: column_type, enumeration: enumeration)
        add_validation(attribute_name: attribute_name, column_type: column_type, enumeration: enumeration)
      end

      private

      def define_type(attribute_name:, column_type:, enumeration:)
        attribute attribute_name, type_for(column_type: column_type, enumeration: enumeration)
      end

      def  add_validation(attribute_name:, column_type:, enumeration:)
        case column_type
        when :value
          validates attribute_name, inclusion: { in: enumeration.list }
        when :array
          #TODO add array validation
        end
      end

      def type_for(column_type:, enumeration:)
        case column_type
        when :value
          value_type_for_enum(enumeration)
        when :array
          array_type_for_enum(enumeration)
        end
      end

      def value_type_for_enum(enumeration)
        EnumType.new(enum: enumeration)
      end

      def array_type_for_enum(enumeration)
        raise InvalidColumnTypeForAdapterTypeError unless postgres_connection?
        PostgreSQLArrayType.new(EnumType.new(enum: enumeration))
      end

      def postgres_connection?
        ::ActiveRecord::Base.connection.is_a?(PostgreSQLAdapter)
      end
    end
  end
end
