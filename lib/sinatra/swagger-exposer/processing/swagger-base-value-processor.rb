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

        def process(params)
          unless params.is_a? Hash
            raise SwaggerInvalidException.new("Value [#{@name}] should be an object but is a [#{params.class}]")
          end

          if @attributes_processors
            @attributes_processors.each do |attributes_processor|
              if attributes_processor.required && !params.key?(attributes_processor.name)
                raise SwaggerInvalidException.new("Mandatory value [#{attributes_processor.name}] is missing")
              end
            end
          end

          params.each_pair do |key, value|
            next if key == 'parsed_body' # Do not validate 'parsed_body'
            if @attributes_processors.nil?
              # No attribute processor for key
              # Validate against self attributes
              value = @default if value.nil? && @default
              validate_value(value) # Local param validation
            else
              # Validate against processor
              attributes_processor = @attributes_processors.find {|ap| ap.name == key}
              if attributes_processor.nil?
                raise SwaggerInvalidException, "Extra object [#{@name}] found"
              end
              value = attributes_processor.default if value.nil? && attributes_processor.default
              attributes_processor.validate_value(value)
            end
          end
          params
        end
      end
    end
  end
end