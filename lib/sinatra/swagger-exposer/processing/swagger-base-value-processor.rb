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

        def process(value, parsed_body = nil)
          # unless value.is_a? Hash
          #   raise SwaggerInvalidException.new("Value [#{@name}] should be an object but is a [#{parsed_body.class}]")
          # end
          if @attributes_processors.nil?
            # No attribute processor for key
            # Validate against self attributes
            value = @default if value.nil? && @default
            if value.nil? && !@required
              # Nothing to do
            else
              validate_value(value) # Local param validation
            end
          else
            # Validate against processor
            @attributes_processors.each do |attributes_processor|
              if attributes_processor.nil?
                raise SwaggerInvalidException, "Extra object [#{@name}] found"
              end
              attributes_processor.validate_value(value[attributes_processor.name.to_s])
            end
          end
          parsed_body[@name.to_s] = value unless parsed_body.nil?
        end
      end
    end
  end
end