# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :find_recipe, only: :show

  def index
    @items = Recipes.all
  end

  def show
    return render file: 'public/404.html', status: :not_found if @item.blank?

    render :show
  end

  private

  def find_recipe
    @item = Recipes.find(params[:id])
  end
end
