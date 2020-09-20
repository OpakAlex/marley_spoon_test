# frozen_string_literal: true

module Recipes
  module Entities
    class Asset < Dry::Struct
      module Types
        include Dry.Types()
      end

      attribute :id, Types::String
      attribute :url, Types::String

      def self.wrap_entity(item)
        new(id: item['sys']['id'], url: extract_url(item['fields']))
      end

      def self.extract_url(fields)
        url_value = fields['file']['url']
        return "https:#{url_value}" if url_value =~ %r{^//}

        url_value
      end
    end
  end
end
