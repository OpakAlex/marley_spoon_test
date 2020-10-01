# frozen_string_literal: true

module Recipes
  module Repositories
    class RecipeRepository
      attr_reader :items, :includes

      def initialize
        @items, @includes = parse(api_response)
      end

      def all
        create_entities
      end

      def find_by_id(id)
        items['recipe'] = [filter_recipe_by_id(items['recipe'], id)]
        create_entities.first
      end

      private

      def api_response
        all_api_getway.call.body
      end

      def filter_recipe_by_id(recipes, id)
        recipes.find { |recipe| recipe['sys']['id'] == id }
      end

      def all_api_getway
        ::Recipes::Outbound::Requests::Recipes.new
      end

      def parse(json)
        response = JSON.parse(json)
        grouped = response['items'].group_by { |item| item['sys']['contentType']['sys']['id'] }
        [grouped, response['includes']]
      end

      def create_entities
        assets = create_assets(includes['Asset'])
        chefs = create_chefs(items['chef'])
        tags = create_tags(items['tag'])
        items['recipe'].map do |item|
          create_recipe(item, assets, chefs, tags)
        end
      end

      def create_recipe(item, assets, chefs, tags)
        return if item.blank?

        ::Recipes::Entities::Recipe.wrap_entity(
          item,
          find_asset(sys_id('photo', item), assets),
          find_chef(sys_id('chef', item), chefs),
          find_tags(sys_ids('tags', item), tags)
        )
      end

      def sys_ids(type, item)
        return unless item

        type_fields = item['fields'][type]
        return [] unless type_fields

        type_fields.map { |field| field['sys']['id'] }
      end

      def sys_id(type, item)
        return unless item

        fields = item['fields']
        return if fields.blank?

        type_fields = fields[type]
        return unless type_fields

        type_fields['sys']['id']
      end

      def find_tags(ids, tags)
        return [] if ids.blank?

        tags.select { |tag| ids.include?(tag.id) }
      end

      def find_chef(id, chefs)
        chefs.find { |chef| chef.id == id }
      end

      def find_asset(id, assets)
        assets.find { |asset| asset.id == id }
      end

      def create_assets(items)
        items.map do |item|
          ::Recipes::Entities::Asset.wrap_entity(item)
        end
      end

      def create_chefs(items)
        items.map do |item|
          ::Recipes::Entities::Chef.wrap_entity(item)
        end
      end

      def create_tags(items)
        items.map do |item|
          ::Recipes::Entities::Tag.wrap_entity(item)
        end
      end
    end
  end
end
