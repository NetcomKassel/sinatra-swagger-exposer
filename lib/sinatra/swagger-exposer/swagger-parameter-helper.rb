module Sinatra

  module SwaggerExposer

    # Helper for handling the parameters
    module SwaggerParameterHelper

      HOW_TO_PASS_BODY = 'body'.freeze
      HOW_TO_PASS_HEADER = 'header'.freeze
      HOW_TO_PASS_PATH = 'path'.freeze
      HOW_TO_PASS_QUERY = 'query'.freeze
      HOW_TO_PASS_FORM_DATA = 'formData'.freeze
      HOW_TO_PASS = [HOW_TO_PASS_PATH, HOW_TO_PASS_QUERY, HOW_TO_PASS_HEADER, HOW_TO_PASS_FORM_DATA, HOW_TO_PASS_BODY].freeze

      TYPE_BOOLEAN = 'boolean'.freeze
      TYPE_BYTE = 'byte'.freeze
      TYPE_DATE = 'date'.freeze
      TYPE_DOUBLE = 'double'.freeze
      TYPE_DATE_TIME = 'dateTime'.freeze
      TYPE_FLOAT = 'float'.freeze
      TYPE_INTEGER = 'integer'.freeze
      TYPE_LONG = 'long'.freeze
      TYPE_NUMBER = 'number'.freeze
      TYPE_PASSWORD = 'password'.freeze
      TYPE_STRING = 'string'.freeze
      TYPE_ARRAY = 'array'.freeze

      TYPE_FILE = 'file'.freeze

      PRIMITIVE_TYPES = [
        TYPE_INTEGER,
        TYPE_LONG,
        TYPE_FLOAT,
        TYPE_DOUBLE,
        TYPE_STRING,
        TYPE_BYTE,
        TYPE_BOOLEAN,
        TYPE_DATE,
        TYPE_DATE_TIME,
        TYPE_PASSWORD,
        TYPE_FILE
      ].freeze

      PRIMITIVE_TYPES_FOR_NON_BODY = [TYPE_STRING, TYPE_NUMBER, TYPE_INTEGER, TYPE_BOOLEAN, TYPE_FILE].freeze

      PARAMS_FORMAT = :format
      PARAMS_DEFAULT = :default
      PARAMS_EXAMPLE = :example

      # For numbers
      PARAMS_MINIMUM = :minimum
      PARAMS_MAXIMUM = :maximum
      PARAMS_EXCLUSIVE_MINIMUM = :exclusiveMinimum
      PARAMS_EXCLUSIVE_MAXIMUM = :exclusiveMaximum

      # For strings
      PARAMS_MIN_LENGTH = :minLength
      PARAMS_MAX_LENGTH = :maxLength

      PARAMS_LIST = [
        PARAMS_FORMAT,
        PARAMS_DEFAULT,
        PARAMS_EXAMPLE,
        PARAMS_MINIMUM,
        PARAMS_MAXIMUM,
        PARAMS_EXCLUSIVE_MINIMUM,
        PARAMS_EXCLUSIVE_MAXIMUM,
        PARAMS_MIN_LENGTH,
        PARAMS_MAX_LENGTH,
      ]

    end

  end
end
