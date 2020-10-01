# frozen_string_literal: true

require 'rails_helper'
RSpec.describe RecipesController, type: :request do
  let(:json) { File.read(Rails.root.join('spec/fixtures/recipes.json')) }

  before do
    allow_any_instance_of(Recipes::Repositories::RecipeRepository).to receive(:api_response).and_return(json)
  end

  describe 'GET /' do
    it 'makes success http request' do
      get recipes_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET /:id' do
    it 'makes success http request' do
      id = '2E8bc3VcJmA8OgmQsageas'
      get recipe_path(id)
      expect(response.status).to eq 200
    end

    it 'return 404 error if id not found' do
      id = 'wrong_id'
      get recipe_path(id)
      expect(response.status).to eq 404
    end
  end
end
