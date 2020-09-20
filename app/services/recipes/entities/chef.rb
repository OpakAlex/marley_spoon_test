# frozen_string_literal: true

module Recipes
  module Entities
    class Chef < Dry::Struct
      module Types
        include Dry.Types()
      end

      attribute :id, Types::String
      attribute :name, Types::String

      def self.wrap_entity(item)
        new(id: item['sys']['id'], name: item['fields']['name'])
      end
    end
  end
end
