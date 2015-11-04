require 'active_model'

module Poppy
  module Rails
    module Validators
      class EnumArrayValidator < ::ActiveModel::EachValidator
        def validate_each(record, attribute, value)
          record.errors.add(attribute, "must only only contain values of type #{enumeration}") unless valid_enums?(value)
        end

        private
        def valid_enums?(array)
          array.select{ |v| enumeration.valid?(v) }.count == array.count
        end

        def enumeration
          options[:as]
        end
      end
    end
  end
end
