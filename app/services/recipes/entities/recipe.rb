# frozen_string_literal: true

require 'dry-struct'

module Recipes
  module Entities
    class Recipe < Dry::Struct
      module Types
        include Dry.Types()
      end

      attribute :id, Types::String
      attribute :title, Types::String
      attribute :description, Types::String

      attribute :asset, Types::Constructor(::Recipes::Entities::Asset).optional
      attribute :chef, Types::Constructor(::Recipes::Entities::Chef).optional
      attribute :tags, Types::Strict::Array.of(::Recipes::Entities::Tag).optional

      def self.wrap_entity(item, asset, chef, tags)
        new(
          id: item['sys']['id'],
          title: item['fields']['title'],
          description: item['fields']['description'],
          asset: asset,
          chef: chef,
          tags: tags
        )
      end
    end
  end
end
