require_relative '../swagger-parameter-helper'

module Sinatra

  module SwaggerExposer

    module Processing

      # Process a response
      class SwaggerResponseProcessor

        include Sinatra::SwaggerExposer::SwaggerParameterHelper

        attr_reader :endpoint_response, :processor

        # Initialize
        # @param endpoint_response [Sinatra::SwaggerExposer::Configuration::SwaggerEndpointResponse]
        # @param processor [Sinatra::SwaggerExposer::Processing::SwaggerTypeValueProcessor]
        def initialize(endpoint_response, processor)
          @endpoint_response = endpoint_response
          @processor = processor
        end

        # Test if the processor is useful
        # @return [TrueClass]
        def useful?
          (@endpoint_response && (@endpoint_response.type != TYPE_FILE)) || @processor
        end

        # Validate a response
        # @param response [Object] the response
        def validate_response(response)
          if response.is_a? String
            begin
              response = ::JSON.parse(response)
            rescue ::JSON::ParserError => _
              raise SwaggerInvalidException.new("Response is not a valid json [#{response}]")
            end
          end
          return @processor.validate_value(response) if @processor
          response
        end
      end
    end
  end
end
