# frozen_string_literal: true

module Recipes
  def self.all
    repository.all
  end

  def self.find(id)
    repository.find_by_id(id)
  end

  def self.repository
    Repositories::RecipeRepository.new
  end
end
