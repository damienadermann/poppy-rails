module Poppy
  module ActiveRecord
    class EnumType < ::ActiveRecord::Type::Value
      class InvalidEnumerationError < StandardError; end;

      attr_accessor :enum

      def initialize(options)
        options.assert_valid_keys(:precision, :scale, :limit, :enum)
        @precision = options[:precision]
        @scale = options[:scale]
        @limit = options[:limit]
        @enum = options[:enum]
      end

      def type_cast(value)
        return value if enum.valid?(value)
        enum.enum_for(value.to_sym)
      end

      def type_cast_for_database(value)
        enum.key_for(value)
      end
    end
  end
end
