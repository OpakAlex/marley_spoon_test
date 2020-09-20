# frozen_string_literal: true

require 'faraday'
require_relative 'errors'

module Recipes
  module Outbound
    class Client
      include Errors

      SUPPORTED_VERBS = %i[get].freeze

      def call(options)
        response = make_request(options)
        handle_errors(response)
        response
      end

      private

      def make_request(options)
        return execute_request(options) if SUPPORTED_VERBS.include?(options[:request_type])

        raise UnsupportedRequestTypeError
      end

      def execute_request(options)
        Faraday.send(options[:request_type], options[:url]) do |req|
          req.headers = options[:headers] if options[:headers].present?
          req.body = options[:body].to_json if options[:body].present?
        end
      end
    end
  end
end
