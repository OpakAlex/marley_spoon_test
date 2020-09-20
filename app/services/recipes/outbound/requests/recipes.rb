# frozen_string_literal: true

require_relative '../client'
require_relative 'request'

module Recipes
  module Outbound
    module Requests
      class Recipes
        include Request
        REQUEST_TYPE = :get
        API_URL = 'https://cdn.contentful.com'

        def initialize
          @client = Outbound::Client.new
          @response = nil
        end

        def call
          options = { request_type: REQUEST_TYPE, url: url }
          @response = @client.call(options)
        end

        private

        def url
          "#{API_URL}/spaces/#{space_id}/entries?access_token=#{access_token}"
        end

        def space_id
          ENV['API_SPACE_ID']
        end

        def access_token
          ENV['API_ACCESS_TOKEN']
        end
      end
    end
  end
end
