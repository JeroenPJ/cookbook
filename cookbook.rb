require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :recipes

  def initialize(csv_file)
    @csv_file = csv_file
    @recipes = load_recipes_array(csv_file)
  end

  def add_recipe(recipe)
    @recipes << recipe
    store_recipes
  end

  def remove_recipe(recipe_id)
    @recipes.delete_at(recipe_id)
    store_recipes
  end

  def mark_as_done(recipe_id)
    recipes[recipe_id].mark_as_done
  end

  def all
    @recipes
  end

  private

  def load_recipes_array(csv_file)
    array = []
    CSV.foreach(csv_file) do |row|
      cooking_time = row[2].to_i
      done = row[3] == "true"
      difficulty = row[4].to_i
      array << Recipe.new(row[0], row[1], cooking_time, done, difficulty)
    end
    array
  end

  def store_recipes
    CSV.open(@csv_file, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.cooking_time, recipe.done, recipe.difficulty]
      end
    end
  end
end
