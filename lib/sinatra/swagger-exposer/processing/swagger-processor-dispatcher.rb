require_relative '../swagger-parameter-helper'

module Sinatra

  module SwaggerExposer

    module Processing

      # Make headers available as a Hash
      class HashForHeaders < Hash

        def initialize(app)
          @app = app
        end

        def [](name)
          @app.request.env[key_to_header_key(name)]
        end

        def key?(name)
          @app.request.env.key?(key_to_header_key(name))
        end

        private

        # In rack the headers name are transformed
        def key_to_header_key(key)
          "HTTP_#{key.gsub(/-/o, '_').upcase}"
        end

      end

      # Dispatch content to a processor
      class SwaggerProcessorDispatcher

        attr_reader :how_to_pass, :processor

        include Sinatra::SwaggerExposer::SwaggerParameterHelper

        # Initialize
        # @param how_to_pass how the value should be passed to the processor
        # @param processor [Sinatra::SwaggerExposer::Processing::SwaggerBaseValueProcessor] processor for the values
        def initialize(how_to_pass, processor)
          @how_to_pass = how_to_pass
          @processor = processor
        end

        def useful?
          (@how_to_pass != HOW_TO_PASS_PATH) && @processor.useful?
        end

        # Process the value
        def process(app, parsed_body)
          value = app.params[@processor.name.to_s]
          case @how_to_pass
            when HOW_TO_PASS_PATH
              # can't validate
            when HOW_TO_PASS_QUERY
              @processor.process(value)
            when HOW_TO_PASS_HEADER
              # TODO: Fix method extra parameter
              @processor.process(value, HashForHeaders.new(value))
            when HOW_TO_PASS_BODY
              real_parsed_body = {"#{@processor.name}": parsed_body}
              @processor.process(parsed_body, real_parsed_body)
            when HOW_TO_PASS_FORM_DATA
              @processor.process(value, parsed_body)
          end
        end

      end
    end
  end
end