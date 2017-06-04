require_relative '../swagger-parameter-helper'
require_relative '../swagger-invalid-exception'

module Sinatra

  module SwaggerExposer

    module Processing

      # Base class for value processor
      class SwaggerBaseValueProcessor

        attr_reader :name, :required

        include Sinatra::SwaggerExposer::SwaggerParameterHelper

        # Initialize
        # @param name [String] the name
        # @param required [TrueClass] if the parameter is required
        # @param default [Object] the default value
        def initialize(name, required, default)
          @name = name.to_s
          @required = required
          @default = default
        end

        # Test if the processor is useful
        # @return [TrueClass]
        def useful?
          @required || (!@default.nil?)
        end

        def process_value(value, response = {})
          if value.nil?
            if @params[:required].nil? || @params[:required]
              raise SwaggerInvalidException, "Missing object [#{@name}]"
            end
          end

          if value.is_a? ActiveRecord::Base
            # Single DB Object
            real_value = value.send @name.to_sym
            if %w[id created_at updated_at].include?(@name) && real_value.nil?
              # Valid to be nil
              response[@name] = nil
            else
              if self.is_a? SwaggerPrimitiveValueProcessor
                response[@name] = validate_value real_value
              elsif self.is_a? SwaggerTypeValueProcessor
                response_sub = {}
                response[@name] = response_sub
                @attributes_processors.each do |attributes_processor|
                  attributes_processor.process_value real_value, response_sub
                end
              end
            end
          elsif value.is_a? ActiveRecord::Relation
            # Relation of Objects (like an Array)
            value.each do |base_or_relation|
              process_value base_or_relation
            end
          else
            # Something else (String, Hash, Array or so)
            if value.is_a? Hash
              response[@name] = validate_value ex_hash_value(value, @name)
            else
              response[@name] = validate_value value
            end
          end
        end

        private

        def ex_hash_value(hash, key)
          hash[key.to_s] || hash[key.to_sym]
        end

      end
    end
  end
end