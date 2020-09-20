# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @items = Recipes.all
  end

  def show
    @item = Recipes.find(params[:id])
  end
end
